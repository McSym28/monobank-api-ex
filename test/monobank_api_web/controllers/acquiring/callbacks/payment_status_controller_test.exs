defmodule MonobankAPIWeb.Acquiring.Callbacks.PaymentStatusControllerTest do
  use MonobankAPIWeb.ConnCase

  import Mox

  @behaviour_module MonobankAPI.Acquiring.CallbacksMock
  @client OpenAPIClientMock

  setup :verify_on_exit!

  describe "payment_status/2" do
    test "[200] processes a request", %{conn: conn} do
      expect(@client, :callback, &OpenAPIClient.callback/1)

      expect(@behaviour_module, :payment_status, fn x_sign, _opts ->
        assert "string" == x_sign
        :ok
      end)

      conn =
        conn
        |> Plug.Conn.put_req_header("x-sign", "string")
        |> post("/__test__/acquiring/callbacks/payment_status?")

      assert response(conn, 200)
    end
  end
end
