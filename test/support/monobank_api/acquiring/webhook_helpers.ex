defmodule MonobankAPI.Acquiring.WebhookHelpers do
  @default_private_key_file "test/fixtures/webhook_private_key.pem"

  @spec generate_x_sign(body :: String.t()) :: String.t()
  def generate_x_sign(body) do
    [key_entry] =
      @default_private_key_file
      |> File.read!()
      |> :public_key.pem_decode()

    {:ECPrivateKey, _version, private_key, {:namedCurve, ec_curve}, _public_key, _parameters} =
      :public_key.pem_entry_decode(key_entry)

    generate_x_sign(body, [private_key, :pubkey_cert_records.namedCurves(ec_curve)])
  end

  @spec generate_x_sign(
          body :: String.t(),
          private_key :: [:crypto.eddsa_private() | :crypto.eddsa_params()]
        ) :: String.t()
  def generate_x_sign(body, private_key) do
    :ecdsa
    |> :crypto.sign(:sha256, body, private_key)
    |> Base.encode64()
  end
end
