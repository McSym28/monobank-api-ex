defmodule MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest do
  @moduledoc """
  Provides struct and type for a Invoices.CreateDirectPaymentRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          card_data: MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData.t(),
          ccy: integer | nil,
          initiation_kind: :client | :merchant | String.t() | nil,
          merchant_paym_info: MonobankAPI.Acquiring.Merchants.PaymentInfo.t() | nil,
          payment_type: :debit | :hold | String.t() | nil,
          redirect_url: String.t() | nil,
          save_card_data:
            MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData.t() | nil,
          web_hook_url: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :card_data]
  defstruct [
    :amount,
    :card_data,
    :ccy,
    :initiation_kind,
    :merchant_paym_info,
    :payment_type,
    :redirect_url,
    :save_card_data,
    :web_hook_url
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      card_data:
        {"cardData", {MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData, :t}},
      ccy: {"ccy", :integer},
      initiation_kind:
        {"initiationKind", {:enum, [{:client, "client"}, {:merchant, "merchant"}, :not_strict]}},
      merchant_paym_info: {"merchantPaymInfo", {MonobankAPI.Acquiring.Merchants.PaymentInfo, :t}},
      payment_type: {"paymentType", {:enum, [{:debit, "debit"}, {:hold, "hold"}, :not_strict]}},
      redirect_url: {"redirectUrl", {:string, :generic}},
      save_card_data:
        {"saveCardData",
         {MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData, :t}},
      web_hook_url: {"webHookUrl", {:string, :generic}}
    ]
  end
end
