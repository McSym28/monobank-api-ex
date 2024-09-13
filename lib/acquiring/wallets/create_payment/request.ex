defmodule MonobankAPI.Acquiring.Wallets.CreatePayment.Request do
  @moduledoc """
  Provides struct and type for a Wallets.CreatePayment.Request
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          card_token: String.t(),
          ccy: integer,
          initiation_kind: :client | :merchant | String.t(),
          merchant_paym_info: MonobankAPI.Acquiring.Merchants.PaymentInfo.t() | nil,
          redirect_url: String.t() | nil,
          web_hook_url: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :card_token, :ccy, :initiation_kind]
  defstruct [
    :amount,
    :card_token,
    :ccy,
    :initiation_kind,
    :merchant_paym_info,
    :redirect_url,
    :web_hook_url
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      card_token: {"cardToken", {:string, :generic}},
      ccy: {"ccy", {:integer, :int32}},
      initiation_kind:
        {"initiationKind", {:enum, [{:client, "client"}, {:merchant, "merchant"}, :not_strict]}},
      merchant_paym_info: {"merchantPaymInfo", {MonobankAPI.Acquiring.Merchants.PaymentInfo, :t}},
      redirect_url: {"redirectUrl", {:string, :generic}},
      web_hook_url: {"webHookUrl", {:string, :generic}}
    ]
  end
end
