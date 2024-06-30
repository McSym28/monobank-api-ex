defmodule MonobankAPI.Acquiring.Merchants.DetailsResponse do
  @moduledoc """
  Provides struct and type for a Merchants.DetailsResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{edrpou: String.t(), merchant_id: String.t(), merchant_name: String.t()}
  @type types :: :t

  @enforce_keys [:edrpou, :merchant_id, :merchant_name]
  defstruct [:edrpou, :merchant_id, :merchant_name]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      edrpou: {"edrpou", {:string, :generic}},
      merchant_id: {"merchantId", {:string, :generic}},
      merchant_name: {"merchantName", {:string, :generic}}
    ]
  end
end
