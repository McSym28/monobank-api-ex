import Config

if config_env() in [:dev, :prod] do
  config :monobank_api_ex,
    webhook_public_key:
      (cond do
         base64 = System.get_env("MONOBANK_WEBHOOK_PUBLIC_KEY_BASE64") -> {:pem_base64, base64}
         file = System.get_env("MONOBANK_WEBHOOK_PUBLIC_KEY_FILE") -> {:pem_file, file}
         :else -> nil
       end),
    token:
      System.get_env("MONOBANK_API_TOKEN") ||
        raise("environment variable MONOBANK_API_TOKEN is missing.")
end
