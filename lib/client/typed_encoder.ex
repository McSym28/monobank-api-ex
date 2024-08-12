defmodule MonobankAPI.Client.TypedEncoder do
  alias OpenAPIClient.Client.TypedEncoder
  alias OpenAPIClient.Client.Error

  @behaviour TypedEncoder

  @impl TypedEncoder
  @doc """
  Encode a value of a specific type

  ## Examples

    iex> #{__MODULE__}.encode(~U[2024-02-01T01:23:45Z], {:integer, "timestamp-s"}, [], #{__MODULE__})
    {:ok, 1706750625}

  """
  def encode(nil, _, _, _), do: {:ok, nil}

  def encode(%DateTime{} = value, {:integer, "timestamp-s"}, _path, _caller_module) do
    {:ok, DateTime.to_unix(value, :second)}
  end

  def encode(_value, {:integer, "timestamp-s"}, path, _caller_module) do
    {:error,
     Error.new(
       message: "Invalid format for timestamp value",
       reason: :invalid_timestamp_value,
       source: path
     )}
  end

  def encode(value, type, path, caller_module),
    do: TypedEncoder.encode(value, type, path, caller_module)
end
