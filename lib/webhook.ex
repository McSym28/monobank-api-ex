defmodule MonobankAPI.Webhook do
  @type verify_result ::
          :ok
          | {:error,
             :x_sign_base64_decode
             | :public_key_base64_decode
             | {:public_key_read_file, File.posix()}
             | :verify_failed}
  @type public_key :: binary() | {:base64, String.t()} | {:file, String.t() | Path.t()}

  @spec verify(binary(), String.t()) :: verify_result()
  @spec verify(binary(), String.t(), [{:public_key, public_key()}]) :: verify_result()
  def verify(body, x_sign_base64, opts \\ []) do
    with {:ok, x_sign_binary} <- decode_x_sign(x_sign_base64),
         {:ok, public_key_binary} <-
           opts
           |> Keyword.get_lazy(:public_key, fn ->
             Application.get_env(:monobank_api_ex, :webhook_public_key)
           end)
           |> get_public_key(),
         {:ok, public_key} <- decode_public_key(public_key_binary) do
      do_verify(body, x_sign_binary, public_key)
    end
  end

  defp decode_x_sign(x_sign_base64) do
    decode_base64(x_sign_base64, :x_sign_base64_decode)
  end

  defp get_public_key({:base64, public_key_base64}) do
    decode_base64(public_key_base64, :public_key_base64_decode)
  end

  defp get_public_key({:file, public_key_file}) do
    case File.read(public_key_file) do
      {:ok, binary} -> {:ok, binary}
      {:error, posix} -> {:error, {:public_key_read_file, posix}}
    end
  end

  defp get_public_key(binary) when is_binary(binary), do: {:ok, binary}

  defp decode_base64(base64_string, error_message) do
    case Base.decode64(base64_string) do
      {:ok, binary} -> {:ok, binary}
      :error -> {:error, error_message}
    end
  end

  defp decode_public_key(public_key_binary) do
    [key_entry] = :public_key.pem_decode(public_key_binary)
    public_key = :public_key.pem_entry_decode(key_entry)
    {:ok, public_key}
  end

  defp do_verify(body, x_sign_binary, public_key) do
    if :public_key.verify(body, :sha256, x_sign_binary, public_key) do
      :ok
    else
      {:error, :verify_failed}
    end
  end
end
