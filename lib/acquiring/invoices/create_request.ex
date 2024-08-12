defmodule MonobankAPI.Acquiring.Invoices.CreateRequest do
  @moduledoc """
  Provides struct and type for a Invoices.CreateRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          agent_fee_percent: number | nil,
          amount: integer,
          ccy: integer | nil,
          code: String.t() | nil,
          merchant_paym_info: MonobankAPI.Acquiring.Merchants.PaymentInfo.t() | nil,
          payment_type: :debit | :hold | String.t() | nil,
          qr_id: String.t() | nil,
          redirect_url: String.t() | nil,
          save_card_data: MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData.t() | nil,
          tips_employee_id: String.t() | nil,
          validity: integer | nil,
          web_hook_url: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount]
  defstruct [
    :agent_fee_percent,
    :amount,
    :ccy,
    :code,
    :merchant_paym_info,
    :payment_type,
    :qr_id,
    :redirect_url,
    :save_card_data,
    :tips_employee_id,
    :validity,
    :web_hook_url
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      agent_fee_percent: {"agentFeePercent", {:number, :float}},
      amount: {"amount", {:integer, :int64}},
      ccy: {"ccy", {:integer, :int32}},
      code: {"code", {:string, :generic}},
      merchant_paym_info: {"merchantPaymInfo", {MonobankAPI.Acquiring.Merchants.PaymentInfo, :t}},
      payment_type: {"paymentType", {:enum, [{:debit, "debit"}, {:hold, "hold"}, :not_strict]}},
      qr_id: {"qrId", {:string, :generic}},
      redirect_url: {"redirectUrl", {:string, :generic}},
      save_card_data:
        {"saveCardData", {MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData, :t}},
      tips_employee_id: {"tipsEmployeeId", {:string, :generic}},
      validity: {"validity", {:integer, :int64}},
      web_hook_url: {"webHookUrl", {:string, :generic}}
    ]
  end
end
