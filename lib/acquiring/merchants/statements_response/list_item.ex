defmodule MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem do
  @moduledoc """
  Provides struct and type for a Merchants.StatementsResponse.ListItem
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          approval_code: String.t() | nil,
          cancel_list:
            [MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem.CancelListItem.t()] | nil,
          ccy: integer,
          date: DateTime.t(),
          destination: String.t() | nil,
          invoice_id: String.t(),
          masked_pan: String.t(),
          payment_scheme: :bnpl_later_30 | :bnpl_parts_4 | :full | String.t(),
          profit_amount: integer | nil,
          reference: String.t() | nil,
          rrn: String.t() | nil,
          short_qr_id: String.t() | nil,
          status: :failure | :hold | :processing | :success | String.t()
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy, :date, :invoice_id, :masked_pan, :payment_scheme, :status]
  defstruct [
    :amount,
    :approval_code,
    :cancel_list,
    :ccy,
    :date,
    :destination,
    :invoice_id,
    :masked_pan,
    :payment_scheme,
    :profit_amount,
    :reference,
    :rrn,
    :short_qr_id,
    :status
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      approval_code: {"approvalCode", {:string, :generic}},
      cancel_list:
        {"cancelList",
         [{MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem.CancelListItem, :t}]},
      ccy: {"ccy", :integer},
      date: {"date", {:string, :date_time}},
      destination: {"destination", {:string, :generic}},
      invoice_id: {"invoiceId", {:string, :generic}},
      masked_pan: {"maskedPan", {:string, :generic}},
      payment_scheme:
        {"paymentScheme",
         {:enum,
          [
            {:bnpl_later_30, "bnpl_later_30"},
            {:bnpl_parts_4, "bnpl_parts_4"},
            {:full, "full"},
            :not_strict
          ]}},
      profit_amount: {"profitAmount", :integer},
      reference: {"reference", {:string, :generic}},
      rrn: {"rrn", {:string, :generic}},
      short_qr_id: {"shortQrId", {:string, :generic}},
      status:
        {"status",
         {:enum,
          [
            {:failure, "failure"},
            {:hold, "hold"},
            {:processing, "processing"},
            {:success, "success"},
            :not_strict
          ]}}
    ]
  end
end
