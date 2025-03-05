defmodule MonobankAPI.Plugs.Acquiring.WebhookSignatureCheckerTest do
  use ExUnit.Case, async: true

  import Plug.Conn
  import Mox

  alias MonobankAPI.Plugs.Acquiring.WebhookSignatureChecker
  alias MonobankAPI.Acquiring.WebhookHelpers

  @public_key_file "test/fixtures/webhook_public_key.pem"
  @httpoison OpenAPIClient.HTTPoisonMock
  @client OpenAPIClientMock

  setup :verify_on_exit!

  describe "call/2" do
    setup do
      body = """
      {
        "a": "1",
        "b": false
      }
      """

      conn =
        Phoenix.ConnTest.build_conn()
        |> put_req_header("content-type", "application/json")
        |> Plug.Adapters.Test.Conn.conn("POST", "/test", body)

      {:ok, conn: conn, body: body}
    end

    test "successfully validates signature with default options", %{conn: conn, body: body} do
      x_sign = WebhookHelpers.generate_x_sign(body)

      assert %Plug.Conn{} =
               conn
               |> put_req_header("x-sign", x_sign)
               |> WebhookSignatureChecker.call(WebhookSignatureChecker.init([]))
    end

    test "successfully validates signature with dynamic keys", %{conn: conn, body: body} do
      ec_curve = :secp256r1
      {public_key, private_key} = :crypto.generate_key(:ecdh, ec_curve)
      x_sign = WebhookHelpers.generate_x_sign(body, [private_key, ec_curve])

      self = self()

      public_key_reader = fn ->
        send(self, :public_key_reader_called)
        {:ok, [public_key, ec_curve]}
      end

      assert %Plug.Conn{} =
               conn
               |> put_req_header("x-sign", x_sign)
               |> WebhookSignatureChecker.call(
                 WebhookSignatureChecker.init(public_key_reader: public_key_reader)
               )

      assert_received :public_key_reader_called
    end

    test "successfully validates signature with fetching fresh public key on initial validation failure",
         %{
           conn: conn,
           body: body
         } do
      ec_curve = :secp256r1
      {public_key, _private_key} = :crypto.generate_key(:ecdh, ec_curve)
      x_sign = WebhookHelpers.generate_x_sign(body)

      self = self()

      public_key_reader = fn ->
        send(self, :public_key_reader_called)
        {:ok, [public_key, ec_curve]}
      end

      public_key_writer = fn public_key ->
        send(self, {:public_key_writer_called, public_key})
        :ok
      end

      expect(@client, :operation, &OpenAPIClient.operation/2)

      expect(@httpoison, :request, fn :get, "https://example.com/api/merchant/pubkey", _, _, _ ->
        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "key" =>
                     @public_key_file
                     |> File.read!()
                     |> Base.encode64()
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert %Plug.Conn{} =
               conn
               |> put_req_header("x-sign", x_sign)
               |> WebhookSignatureChecker.call(
                 WebhookSignatureChecker.init(
                   public_key_reader: public_key_reader,
                   public_key_fetch_opts: [base_url: "https://example.com"],
                   public_key_writer: public_key_writer
                 )
               )

      assert_received :public_key_reader_called
      assert_received {:public_key_writer_called, {:pem_base64, _public_key}}
    end

    test "fails to validate signature with fetching public key returns the same key on initial validation failure",
         %{
           conn: conn,
           body: body
         } do
      ec_curve = :secp256r1
      {_public_key, private_key} = :crypto.generate_key(:ecdh, ec_curve)
      x_sign = WebhookHelpers.generate_x_sign(body, [private_key, ec_curve])

      self = self()

      public_key_writer = fn public_key ->
        send(self, {:public_key_writer_called, public_key})
        :ok
      end

      expect(@client, :operation, &OpenAPIClient.operation/2)

      expect(@httpoison, :request, fn :get, "https://example.com/api/merchant/pubkey", _, _, _ ->
        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "key" =>
                     @public_key_file
                     |> File.read!()
                     |> Base.encode64()
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert_raise OpenAPIClient.Error, "Signature verification failed", fn ->
        conn
        |> put_req_header("x-sign", x_sign)
        |> WebhookSignatureChecker.call(
          WebhookSignatureChecker.init(
            public_key_fetch_opts: [base_url: "https://example.com"],
            public_key_writer: public_key_writer
          )
        )
      end

      assert_received {:public_key_writer_called, {:pem_base64, _public_key}}
    end

    test "fails to validate signature with fetching public key fails on initial validation failure",
         %{
           conn: conn,
           body: body
         } do
      ec_curve = :secp256r1
      {_public_key, private_key} = :crypto.generate_key(:ecdh, ec_curve)
      x_sign = WebhookHelpers.generate_x_sign(body, [private_key, ec_curve])

      expect(@client, :operation, &OpenAPIClient.operation/2)

      expect(@httpoison, :request, fn :get, "https://example.com/api/merchant/pubkey", _, _, _ ->
        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "err_code", "err_text" => "err_text"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert_raise OpenAPIClient.Error, "Signature verification failed", fn ->
        conn
        |> put_req_header("x-sign", x_sign)
        |> WebhookSignatureChecker.call(
          WebhookSignatureChecker.init(public_key_fetch_opts: [base_url: "https://example.com"])
        )
      end
    end
  end
end
