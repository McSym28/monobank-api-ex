defmodule MonobankAPI.Acquiring.Invoices.FinalizeRequest do
  @moduledoc """
  Provides struct and type for a Invoices.FinalizeRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer | nil,
          invoice_id: String.t(),
          items: [MonobankAPI.Acquiring.Invoices.FiscalizationItem.t()] | nil
        }
  @type types :: :t

  @enforce_keys [:invoice_id]
  defstruct [:amount, :invoice_id, :items]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      invoice_id: {"invoiceId", {:string, :generic}},
      items: {"items", [{MonobankAPI.Acquiring.Invoices.FiscalizationItem, :t}]}
    ]
  end
end
