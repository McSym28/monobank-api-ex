defmodule MonobankAPI.Acquiring.Invoices.CancelRequest do
  @moduledoc """
  Provides struct and type for a Invoices.CancelRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer | nil,
          ext_ref: String.t() | nil,
          invoice_id: String.t(),
          items: [MonobankAPI.Acquiring.Invoices.FiscalizationItem.t()] | nil
        }
  @type types :: :t

  @enforce_keys [:invoice_id]
  defstruct [:amount, :ext_ref, :invoice_id, :items]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      ext_ref: {"extRef", {:string, :generic}},
      invoice_id: {"invoiceId", {:string, :generic}},
      items: {"items", [{MonobankAPI.Acquiring.Invoices.FiscalizationItem, :t}]}
    ]
  end
end
