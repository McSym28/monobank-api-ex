defmodule MonobankAPIWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :monobank_api_ex

  plug(MonobankAPI.Plugs.RawBodyReader)

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Phoenix.json_library(),
    body_reader: {MonobankAPI.Plugs.RawBodyReader, :read_body, []}
  )

  plug(MonobankAPIWeb.Router)
end
