defmodule MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse.Item do
  @moduledoc """
  Provides struct and type for a Merchants.Submerchants.ListResponse.Item
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{code: String.t(), edrpou: String.t() | nil, iban: String.t()}
  @type types :: :t

  @enforce_keys [:code, :iban]
  defstruct [:code, :edrpou, :iban]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      code: {"code", {:string, :generic}},
      edrpou: {"edrpou", {:string, :generic}},
      iban: {"iban", {:string, :generic}}
    ]
  end
end
