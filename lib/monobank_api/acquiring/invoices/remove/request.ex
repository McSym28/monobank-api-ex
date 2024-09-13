defmodule MonobankAPI.Acquiring.Invoices.Remove.Request do
  @moduledoc """
  Provides struct and type for a Invoices.Remove.Request
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{invoice_id: String.t()}
  @type types :: :t

  @enforce_keys [:invoice_id]
  defstruct [:invoice_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [invoice_id: {"invoiceId", {:string, :generic}}]
  end
end
