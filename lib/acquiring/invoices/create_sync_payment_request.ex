defmodule MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest do
  @moduledoc """
  Provides struct and type for a Invoices.CreateSyncPaymentRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          apple_pay: MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay.t() | nil,
          card_data: MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData.t() | nil,
          ccy: integer,
          google_pay: MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay.t() | nil,
          merchant_paym_info:
            MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy]
  defstruct [:amount, :apple_pay, :card_data, :ccy, :google_pay, :merchant_paym_info]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      apple_pay:
        {"applePay", {MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay, :t}},
      card_data:
        {"cardData", {MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData, :t}},
      ccy: {"ccy", {:integer, :int32}},
      google_pay:
        {"googlePay", {MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay, :t}},
      merchant_paym_info:
        {"merchantPaymInfo",
         {MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo, :t}}
    ]
  end
end
