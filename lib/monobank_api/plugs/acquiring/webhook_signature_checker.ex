defmodule MonobankAPI.Plugs.Acquiring.WebhookSignatureChecker do
  @moduledoc """
  A plug for checking a webhook signature from `X-Sign` header.

  This plug MUST be called after the `OpenAPIClient.Plugs.CallbackInitializer` plug
  (to initialize `:open_api_client_ex` state).

  ## Options:
  * `:body_reader` - MFA to read request body. By default the `MonobankAPI.Plugs.RawBodyReader.read_body/2` is used.
  * `:public_key` - Public used for signature verification.

  """

  @behaviour Plug

  alias OpenAPIClient.Error

  @type option ::
          {:body_reader, {module(), atom(), list()}}
          | {:public_key, MonobankAPI.Acquiring.Webhook.public_key()}
  @type options :: [option()]

  @impl Plug
  @spec init(options()) :: Plug.opts()
  def init(opts) do
    {body_reader, opts} =
      Keyword.pop(opts, :body_reader, {MonobankAPI.Plugs.RawBodyReader, :read_body, []})

    {body_reader, opts}
  end

  @impl Plug
  @spec call(Plug.Conn.t(), Plug.opts()) :: Plug.Conn.t()
  def call(conn, {body_reader, opts}) do
    with {:ok, x_sign_base64} <- get_x_sign_header(conn),
         {:ok, public_key} <- get_public_key(conn, opts),
         {:ok, body, conn} <- read_body(conn, body_reader, opts),
         :ok <- verify_body(conn, body, x_sign_base64, public_key) do
      conn
    end
  end

  defp get_x_sign_header(conn) do
    conn
    |> Plug.Conn.get_req_header("x-sign")
    |> case do
      [sign] ->
        {:ok, sign}

      _ ->
        raise Error.new(
                message: "Header `X-Sign` not set",
                reason: :header_x_sign_not_set,
                conn: conn,
                plug: __MODULE__
              )
    end
  end

  defp get_public_key(conn, opts) do
    opts
    |> Keyword.get_lazy(:public_key, fn ->
      Application.get_env(:monobank_api_ex, :webhook_public_key)
    end)
    |> case do
      nil ->
        raise Error.new(
                message: "Public key not set",
                reason: :public_key_not_set,
                conn: conn,
                plug: __MODULE__
              )

      public_key ->
        {:ok, public_key}
    end
  end

  defp read_body(conn, {mod, fun, args}, opts) do
    case apply(mod, fun, [conn, opts | args]) do
      {:ok, body, conn} ->
        {:ok, body, conn}

      {:more, _, conn} ->
        raise Error.new(
                message: "Request body is too large",
                reason: :request_body_too_large,
                conn: conn,
                plug: __MODULE__
              )

      {:error, reason} ->
        raise Error.new(
                message: "Request body read error",
                reason: :request_body_read_error,
                source: reason,
                conn: conn,
                plug: __MODULE__
              )
    end
  end

  defp verify_body(conn, body, x_sign_base64, public_key) do
    case MonobankAPI.Acquiring.Webhook.verify(body, x_sign_base64, public_key: public_key) do
      :ok ->
        :ok

      {:error, reason} ->
        raise Error.new(
                message: "Signature verification failed",
                reason: :signature_verification_error,
                source: reason,
                conn: conn,
                plug: __MODULE__
              )
    end
  end
end
