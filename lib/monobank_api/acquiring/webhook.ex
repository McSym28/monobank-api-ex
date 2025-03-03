defmodule MonobankAPI.Acquiring.Webhook do
  @type verify_result ::
          :ok
          | {:error,
             :x_sign_base64_decode
             | :public_key_base64_decode
             | {:public_key_read_file, File.posix()}
             | :verify_failed}
  @type public_key ::
          {:pem, binary()}
          | {:pem_base64, String.t()}
          | {:pem_file, String.t() | Path.t()}
          | [:crypto.ecdsa_public() | :crypto.ecdsa_params()]

  @spec verify(binary(), String.t()) :: verify_result()
  @spec verify(binary(), String.t(), [{:public_key, public_key()}]) :: verify_result()
  def verify(body, x_sign_base64, opts \\ []) do
    with {:ok, x_sign_binary} <- decode_x_sign(x_sign_base64),
         {:ok, public_key} <-
           opts
           |> Keyword.get_lazy(:public_key, fn ->
             Application.get_env(:monobank_api_ex, :webhook_public_key)
           end)
           |> get_public_key() do
      do_verify(body, x_sign_binary, public_key)
    end
  end

  defp decode_x_sign(x_sign_base64) do
    decode_base64(x_sign_base64, :x_sign_base64_decode)
  end

  defp get_public_key({:pem, public_key_binary}) do
    with [key_entry] = :public_key.pem_decode(public_key_binary),
         {{:ECPoint, point}, {:namedCurve, curve}} <- :public_key.pem_entry_decode(key_entry) do
      ec_curve = :pubkey_cert_records.namedCurves(curve)
      {:ok, [point, ec_curve]}
    else
      _ -> {:error, :public_key_pem_decode}
    end
  end

  defp get_public_key({:pem_base64, public_key_base64}) do
    with {:ok, binary} <- decode_base64(public_key_base64, :public_key_base64_decode) do
      get_public_key({:pem, binary})
    end
  end

  defp get_public_key({:pem_file, public_key_file}) do
    case File.read(public_key_file) do
      {:ok, binary} -> get_public_key({:pem, binary})
      {:error, posix} -> {:error, {:public_key_read_file, posix}}
    end
  end

  defp get_public_key([_public_key, _params] = key), do: {:ok, key}

  defp decode_base64(base64_string, error_message) do
    case Base.decode64(base64_string) do
      {:ok, binary} -> {:ok, binary}
      :error -> {:error, error_message}
    end
  end

  defp do_verify(body, x_sign_binary, public_key) do
    if :crypto.verify(:ecdsa, :sha256, body, x_sign_binary, public_key) do
      :ok
    else
      {:error, :verify_failed}
    end
  end
end
