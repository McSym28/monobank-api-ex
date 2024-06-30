defmodule MonobankAPI.Acquiring.Invoices.PaymentInfoResponse do
  @moduledoc """
  Provides struct and type for a Invoices.PaymentInfoResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          approval_code: String.t(),
          cancel_list: [MonobankAPI.Acquiring.Invoices.CancelListItem.t()] | nil,
          ccy: integer,
          country: String.t(),
          created_date: DateTime.t() | nil,
          domestic_card: boolean,
          fee: integer | nil,
          final_amount: integer,
          masked_pan: String.t(),
          payment_method: :apple | :google | :monobank | :pan | :wallet | String.t(),
          payment_scheme: :bnpl_later_30 | :bnpl_parts_4 | :full | String.t(),
          rrn: String.t(),
          terminal: String.t()
        }
  @type types :: :t

  @enforce_keys [
    :amount,
    :approval_code,
    :ccy,
    :country,
    :domestic_card,
    :final_amount,
    :masked_pan,
    :payment_method,
    :payment_scheme,
    :rrn,
    :terminal
  ]
  defstruct [
    :amount,
    :approval_code,
    :cancel_list,
    :ccy,
    :country,
    :created_date,
    :domestic_card,
    :fee,
    :final_amount,
    :masked_pan,
    :payment_method,
    :payment_scheme,
    :rrn,
    :terminal
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      approval_code: {"approvalCode", {:string, :generic}},
      cancel_list: {"cancelList", [{MonobankAPI.Acquiring.Invoices.CancelListItem, :t}]},
      ccy: {"ccy", :integer},
      country: {"country", {:string, :generic}},
      created_date: {"createdDate", {:string, :date_time}},
      domestic_card: {"domesticCard", :boolean},
      fee: {"fee", :integer},
      final_amount: {"finalAmount", :integer},
      masked_pan: {"maskedPan", {:string, :generic}},
      payment_method:
        {"paymentMethod",
         {:enum,
          [
            {:apple, "apple"},
            {:google, "google"},
            {:monobank, "monobank"},
            {:pan, "pan"},
            {:wallet, "wallet"},
            :not_strict
          ]}},
      payment_scheme:
        {"paymentScheme",
         {:enum,
          [
            {:bnpl_later_30, "bnpl_later_30"},
            {:bnpl_parts_4, "bnpl_parts_4"},
            {:full, "full"},
            :not_strict
          ]}},
      rrn: {"rrn", {:string, :generic}},
      terminal: {"terminal", {:string, :generic}}
    ]
  end
end
