import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :monobank_api_ex, MonobankAPIWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GDoj2d2XJ/S1YNhf5HQR3ajTysEoFpLBfnNSJHkEVYTcb6y9l/tSlOkoSZW29rzc",
  server: false

# Initialize plugs at runtime for faster test compilation
# Use Jason for JSON parsing in Phoenix
config :phoenix,
  plug_init_mode: :runtime,
  json_library: Jason

# Print only warnings and errors during test
config :logger, level: :warning

config :monobank_api_ex,
  webhook_public_key: {:pem_file, "test/fixtures/webhook_public_key.pem"},
  token: "your_token"

config :open_api_client_ex,
  "$base": [
    httpoison: OpenAPIClient.HTTPoisonMock,
    client: OpenAPIClientMock
  ]
