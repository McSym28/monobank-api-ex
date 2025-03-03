defmodule MonobankAPI.Plugs.RawBodyReader do
  @moduledoc """
  A plug for reading request's body and storing it in `Plug.Conn`.

  ## Options:
  * `:body_reader` - MFA to read request body. By default the `Plug.Conn.read_body/2` is used.

  """

  @behaviour Plug

  alias OpenAPIClient.Error

  @type option :: {:body_reader, {module(), atom(), list()}}
  @type options :: [option()]

  @raw_body_key :monobank_raw_body

  @impl Plug
  @spec init(options()) :: Plug.opts()
  def init(opts) do
    {body_reader, opts} = Keyword.pop(opts, :body_reader, {Plug.Conn, :read_body, []})
    {body_reader, opts}
  end

  @impl Plug
  @spec call(Plug.Conn.t(), Plug.opts()) :: Plug.Conn.t()
  def call(conn, {body_reader, opts}) do
    {:ok, body, conn} = read_raw_body(conn, "", body_reader, opts)
    Plug.Conn.assign(conn, @raw_body_key, body)
  end

  defp read_raw_body(conn, current_body, {mod, fun, args} = body_reader, opts) do
    case apply(mod, fun, [conn, opts | args]) do
      {:ok, body, conn} ->
        {:ok, current_body <> body, conn}

      {:more, body, conn} ->
        read_raw_body(conn, current_body <> body, body_reader, opts)

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

  @spec read_body(conn :: Plug.Conn.t(), opts :: Keyword.t()) ::
          {:ok, binary(), Plug.Conn.t()} | {:error, term()}
  def read_body(%Plug.Conn{assigns: %{@raw_body_key => body}} = conn, _opts) do
    {:ok, body, conn}
  end

  def read_body(conn, opts) do
    read_raw_body(conn, "", {Plug.Conn, :read_body, []}, opts)
  end
end
