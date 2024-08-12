defmodule MonobankAPI.Acquiring.Invoices.StatusResponse do
  @moduledoc """
  Provides struct and type for a Invoices.StatusResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          cancel_list: [MonobankAPI.Acquiring.Invoices.CancelListItem.t()] | nil,
          ccy: integer,
          created_date: DateTime.t() | nil,
          destination: String.t() | nil,
          err_code: String.t() | nil,
          failure_reason: String.t() | nil,
          final_amount: integer | nil,
          invoice_id: String.t(),
          modified_date: DateTime.t() | nil,
          payment_info: MonobankAPI.Acquiring.Invoices.StatusResponse.PaymentInfo.t() | nil,
          reference: String.t() | nil,
          status:
            :created
            | :expired
            | :failure
            | :hold
            | :processing
            | :reversed
            | :success
            | String.t(),
          tips_info: MonobankAPI.Acquiring.Invoices.StatusResponse.TipsInfo.t() | nil,
          wallet_data: MonobankAPI.Acquiring.Invoices.StatusResponse.WalletData.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy, :invoice_id, :status]
  defstruct [
    :amount,
    :cancel_list,
    :ccy,
    :created_date,
    :destination,
    :err_code,
    :failure_reason,
    :final_amount,
    :invoice_id,
    :modified_date,
    :payment_info,
    :reference,
    :status,
    :tips_info,
    :wallet_data
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      cancel_list: {"cancelList", [{MonobankAPI.Acquiring.Invoices.CancelListItem, :t}]},
      ccy: {"ccy", {:integer, :int32}},
      created_date: {"createdDate", {:string, :date_time}},
      destination: {"destination", {:string, :generic}},
      err_code: {"errCode", {:string, :generic}},
      failure_reason: {"failureReason", {:string, :generic}},
      final_amount: {"finalAmount", {:integer, :int64}},
      invoice_id: {"invoiceId", {:string, :generic}},
      modified_date: {"modifiedDate", {:string, :date_time}},
      payment_info:
        {"paymentInfo", {MonobankAPI.Acquiring.Invoices.StatusResponse.PaymentInfo, :t}},
      reference: {"reference", {:string, :generic}},
      status:
        {"status",
         {:enum,
          [
            {:created, "created"},
            {:expired, "expired"},
            {:failure, "failure"},
            {:hold, "hold"},
            {:processing, "processing"},
            {:reversed, "reversed"},
            {:success, "success"},
            :not_strict
          ]}},
      tips_info: {"tipsInfo", {MonobankAPI.Acquiring.Invoices.StatusResponse.TipsInfo, :t}},
      wallet_data: {"walletData", {MonobankAPI.Acquiring.Invoices.StatusResponse.WalletData, :t}}
    ]
  end
end
