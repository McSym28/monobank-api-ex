defmodule MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo do
  @moduledoc """
  Provides struct and type for a Invoices.CreateSyncPaymentRequest.MerchantPaymInfo
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{destination: String.t() | nil, reference: String.t() | nil}
  @type types :: :t

  defstruct [:destination, :reference]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      destination: {"destination", {:string, :generic}},
      reference: {"reference", {:string, :generic}}
    ]
  end
end
