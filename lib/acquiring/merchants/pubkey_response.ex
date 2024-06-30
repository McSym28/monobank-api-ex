defmodule MonobankAPI.Acquiring.Merchants.PubkeyResponse do
  @moduledoc """
  Provides struct and type for a Merchants.PubkeyResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{key: String.t()}
  @type types :: :t

  @enforce_keys [:key]
  defstruct [:key]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [key: {"key", {:string, :generic}}]
  end
end
