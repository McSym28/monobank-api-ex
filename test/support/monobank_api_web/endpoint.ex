defmodule MonobankAPIWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :monobank_api_ex

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Phoenix.json_library()
  )

  plug(MonobankAPIWeb.Router)
end
