defmodule MonobankAPI.Acquiring.Invoices.Create.Response do
  @moduledoc """
  Provides struct and type for a Invoices.Create.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{invoice_id: String.t(), page_url: String.t()}
  @type types :: :t

  @enforce_keys [:invoice_id, :page_url]
  defstruct [:invoice_id, :page_url]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [invoice_id: {"invoiceId", {:string, :generic}}, page_url: {"pageUrl", {:string, :generic}}]
  end
end
