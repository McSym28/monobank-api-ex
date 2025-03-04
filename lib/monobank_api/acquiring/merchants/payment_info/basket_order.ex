defmodule MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder do
  @moduledoc """
  Provides struct and type for a Merchants.PaymentInfo.BasketOrder
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          barcode: String.t() | nil,
          code: String.t(),
          discounts: [MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount.t()] | nil,
          footer: String.t() | nil,
          header: String.t() | nil,
          icon: String.t() | nil,
          name: String.t(),
          qty: number,
          sum: integer,
          tax: [integer] | nil,
          total: integer | nil,
          uktzed: String.t() | nil,
          unit: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:code, :name, :qty, :sum]
  defstruct [
    :barcode,
    :code,
    :discounts,
    :footer,
    :header,
    :icon,
    :name,
    :qty,
    :sum,
    :tax,
    :total,
    :uktzed,
    :unit
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      barcode: {"barcode", {:string, :generic}},
      code: {"code", {:string, :generic}},
      discounts:
        {"discounts", [{MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount, :t}]},
      footer: {"footer", {:string, :generic}},
      header: {"header", {:string, :generic}},
      icon: {"icon", {:string, :generic}},
      name: {"name", {:string, :generic}},
      qty: {"qty", {:number, :float}},
      sum: {"sum", {:integer, :int64}},
      tax: {"tax", [:integer]},
      total: {"total", {:integer, :int64}},
      uktzed: {"uktzed", {:string, :generic}},
      unit: {"unit", {:string, :generic}}
    ]
  end
end
