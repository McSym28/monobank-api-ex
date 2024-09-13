defmodule MonobankAPI.Acquiring.Invoices.ListFiscalChecks.Response do
  @moduledoc """
  Provides struct and type for a Invoices.ListFiscalChecks.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          checks: [MonobankAPI.Acquiring.Invoices.ListFiscalChecks.Response.Checks.t()] | nil
        }
  @type types :: :t

  defstruct [:checks]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [checks: {"checks", [{MonobankAPI.Acquiring.Invoices.ListFiscalChecks.Response.Checks, :t}]}]
  end
end
