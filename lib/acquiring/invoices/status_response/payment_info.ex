defmodule MonobankAPI.Acquiring.Invoices.StatusResponse.PaymentInfo do
  @moduledoc """
  Provides struct and type for a Invoices.StatusResponse.PaymentInfo
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          agent_fee: integer | nil,
          approval_code: String.t() | nil,
          bank: String.t() | nil,
          country: String.t() | nil,
          fee: integer | nil,
          masked_pan: String.t(),
          payment_method: :apple | :direct | :google | :monobank | :pan | :wallet | String.t(),
          payment_system: :mastercard | :visa | String.t(),
          rrn: String.t() | nil,
          terminal: String.t(),
          tran_id: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:masked_pan, :payment_method, :payment_system, :terminal]
  defstruct [
    :agent_fee,
    :approval_code,
    :bank,
    :country,
    :fee,
    :masked_pan,
    :payment_method,
    :payment_system,
    :rrn,
    :terminal,
    :tran_id
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      agent_fee: {"agentFee", {:integer, :int64}},
      approval_code: {"approvalCode", {:string, :generic}},
      bank: {"bank", {:string, :generic}},
      country: {"country", {:string, :generic}},
      fee: {"fee", {:integer, :int64}},
      masked_pan: {"maskedPan", {:string, :generic}},
      payment_method:
        {"paymentMethod",
         {:enum,
          [
            {:apple, "apple"},
            {:direct, "direct"},
            {:google, "google"},
            {:monobank, "monobank"},
            {:pan, "pan"},
            {:wallet, "wallet"},
            :not_strict
          ]}},
      payment_system:
        {"paymentSystem", {:enum, [{:mastercard, "mastercard"}, {:visa, "visa"}, :not_strict]}},
      rrn: {"rrn", {:string, :generic}},
      terminal: {"terminal", {:string, :generic}},
      tran_id: {"tranId", {:string, :generic}}
    ]
  end
end
