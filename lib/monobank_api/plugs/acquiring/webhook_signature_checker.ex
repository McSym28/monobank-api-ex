defmodule MonobankAPI.Plugs.Acquiring.WebhookSignatureChecker do
  @moduledoc """
  A plug for checking a webhook signature from `X-Sign` header.

  This plug MUST be called after the `OpenAPIClient.Plugs.CallbackInitializer` plug
  (to initialize `:open_api_client_ex` state).

  ## Options:
  * `:body_reader` - MFA to read request body. By default the `MonobankAPI.Plugs.RawBodyReader.read_body/2` is used.
  * `:public_key_reader` - Function to read public key used for signature verification. Defaults to
    `Application.fetch_env(:monobank_api_ex, :webhook_public_key)`
  * `:public_key_fetch_opts` - Options passed to `MonobankAPI.Acquiring.Merchants.get_pubkey/1` to fetch public key
    on signature verification failure.
  * `:public_key_writer` - Function to write public key fetched on signature verification failure. Fetched public
    key will be passed as the first argument.

  """

  @behaviour Plug

  alias OpenAPIClient.Error

  @type option ::
          {:body_reader, {module(), atom(), list()}}
          | {:public_key_reader,
             {module(), atom(), list()}
             | (-> {:ok, MonobankAPI.Acquiring.Webhook.public_key()} | :error)}
          | {:public_key_fetch_opts, keyword()}
          | {:public_key_writer,
             {module(), atom(), list()} | (MonobankAPI.Acquiring.Webhook.public_key() -> any())}
  @type options :: [option()]

  @impl Plug
  @spec init(options()) :: Plug.opts()
  def init(opts) do
    {body_reader, opts} =
      Keyword.pop(opts, :body_reader, {MonobankAPI.Plugs.RawBodyReader, :read_body, []})

    {body_reader, opts}
  end

  @impl Plug
  def call(conn, {body_reader, opts}) do
    with {:ok, x_sign_base64} <- get_x_sign_header(conn),
         {:ok, public_key} <- get_public_key(conn, opts),
         {:ok, body, conn} <- read_body(conn, body_reader, opts),
         :ok <- verify_body(conn, body, x_sign_base64, public_key, false, opts) do
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
    |> Keyword.get(
      :public_key_reader,
      {Application, :fetch_env, [:monobank_api_ex, :webhook_public_key]}
    )
    |> read_public_key()
    |> case do
      :error ->
        raise Error.new(
                message: "Public key not set",
                reason: :public_key_not_set,
                conn: conn,
                plug: __MODULE__
              )

      {:ok, public_key} ->
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

  defp verify_body(conn, body, x_sign_base64, public_key, was_fetched, opts) do
    case MonobankAPI.Acquiring.Webhook.verify(body, x_sign_base64, public_key: public_key) do
      :ok ->
        :ok

      {:error, reason} ->
        with false <- was_fetched,
             {:ok, %MonobankAPI.Acquiring.Merchants.Pubkey.Response{key: public_key_new}} <-
               opts
               |> Keyword.get(:public_key_fetch_opts, [])
               |> MonobankAPI.Acquiring.Merchants.get_pubkey() do
          public_key_new = {:pem_base64, public_key_new}

          opts
          |> Keyword.get(:public_key_writer)
          |> write_public_key(public_key_new)

          verify_body(conn, body, x_sign_base64, public_key_new, true, opts)
        else
          _ ->
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

  defp read_public_key(fun) when is_function(fun, 0), do: fun.()
  defp read_public_key({module, function, args}), do: apply(module, function, args)

  defp write_public_key(fun, public_key) when is_function(fun, 1), do: fun.(public_key)

  defp write_public_key({module, function, args}, public_key),
    do: apply(module, function, [public_key | args])

  defp write_public_key(nil, _public_key), do: :ok
end
