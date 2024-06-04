import Config

# Print only warnings and errors during test
config :logger, level: :warning

config :monobank_api_ex,
  webhook_public_key: {:file, "test/fixtures/webhook_public_key.pem"}

config :open_api_client_ex,
  "$base": [
    client_pipeline: OpenAPIClient.BasicHTTPoisonPipeline,
    httpoison: OpenAPIClient.HTTPoisonMock,
    decoders: [
      {"application/json", {Jason, :decode, []}}
    ],
    encoders: [
      {"application/json", {Jason, :encode, []}}
    ]
  ]
