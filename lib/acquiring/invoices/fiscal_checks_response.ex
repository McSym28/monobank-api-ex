defmodule MonobankAPI.Acquiring.Invoices.FiscalChecksResponse do
  @moduledoc """
  Provides struct and type for a Invoices.FiscalChecksResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          checks: [MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.Check.t()] | nil
        }
  @type types :: :t

  defstruct [:checks]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [checks: {"checks", [{MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.Check, :t}]}]
  end
end
