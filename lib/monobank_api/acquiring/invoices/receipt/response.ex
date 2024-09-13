defmodule MonobankAPI.Acquiring.Invoices.Receipt.Response do
  @moduledoc """
  Provides struct and type for a Invoices.Receipt.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{file: String.t() | nil}
  @type types :: :t

  defstruct [:file]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [file: {"file", {:string, :generic}}]
  end
end
