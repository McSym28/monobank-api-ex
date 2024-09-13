defmodule MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request do
  @moduledoc """
  Provides struct and type for a Invoices.CreateSyncPayment.Request
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          apple_pay: MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.ApplePay.t() | nil,
          card_data: MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.CardData.t() | nil,
          ccy: integer,
          google_pay:
            MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.GooglePay.t() | nil,
          merchant_paym_info:
            MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.MerchantPaymInfo.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy]
  defstruct [:amount, :apple_pay, :card_data, :ccy, :google_pay, :merchant_paym_info]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      apple_pay:
        {"applePay", {MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.ApplePay, :t}},
      card_data:
        {"cardData", {MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.CardData, :t}},
      ccy: {"ccy", {:integer, :int32}},
      google_pay:
        {"googlePay", {MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.GooglePay, :t}},
      merchant_paym_info:
        {"merchantPaymInfo",
         {MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.MerchantPaymInfo, :t}}
    ]
  end
end
