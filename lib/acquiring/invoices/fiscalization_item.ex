defmodule MonobankAPI.Acquiring.Invoices.FiscalizationItem do
  @moduledoc """
  Provides struct and type for a Invoices.FiscalizationItem
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          barcode: String.t() | nil,
          code: String.t(),
          footer: String.t() | nil,
          header: String.t() | nil,
          name: String.t(),
          qty: number,
          sum: integer,
          tax: [integer] | nil,
          uktzed: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:code, :name, :qty, :sum]
  defstruct [:barcode, :code, :footer, :header, :name, :qty, :sum, :tax, :uktzed]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      barcode: {"barcode", {:string, :generic}},
      code: {"code", {:string, :generic}},
      footer: {"footer", {:string, :generic}},
      header: {"header", {:string, :generic}},
      name: {"name", {:string, :generic}},
      qty: {"qty", {:number, :float}},
      sum: {"sum", {:integer, :int64}},
      tax: {"tax", [:integer]},
      uktzed: {"uktzed", {:string, :generic}}
    ]
  end
end
