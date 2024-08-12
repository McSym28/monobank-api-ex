defmodule MonobankAPI.Client.TypedDecoder do
  alias OpenAPIClient.Client.TypedDecoder
  alias OpenAPIClient.Client.Error

  @behaviour TypedDecoder

  @impl TypedDecoder
  @doc """
  Decode a value of a specific type

  ## Examples
    iex> #{__MODULE__}.decode(1706750625, {:integer, "timestamp-s"}, [], #{__MODULE__})
    {:ok, ~U[2024-02-01T01:23:45Z]}

  """
  def decode(nil, _, _, _), do: {:ok, nil}

  def decode(value, {:integer, "timestamp-s"}, path, _caller_module) when is_integer(value) do
    value
    |> DateTime.from_unix(:second)
    |> case do
      {:ok, value_decoded} ->
        {:ok, value_decoded}

      {:error, reason} ->
        {:error,
         Error.new(
           message: "Error while decoding timestamp value",
           reason: reason,
           source: path
         )}
    end
  end

  def decode(_value, {:integer, "timestamp-s"}, path, _caller_module) do
    {:error,
     Error.new(
       message: "Invalid format for timestamp value",
       reason: :invalid_timestamp_value,
       source: path
     )}
  end

  def decode(value, type, path, caller_module),
    do: TypedDecoder.decode(value, type, path, caller_module)
end
