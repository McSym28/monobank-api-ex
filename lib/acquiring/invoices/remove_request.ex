defmodule MonobankAPI.Acquiring.Invoices.RemoveRequest do
  @moduledoc """
  Provides struct and type for a Invoices.RemoveRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{invoice_id: String.t()}
  @type types :: :t

  @enforce_keys [:invoice_id]
  defstruct [:invoice_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [invoice_id: {"invoiceId", {:string, :generic}}]
  end
end
