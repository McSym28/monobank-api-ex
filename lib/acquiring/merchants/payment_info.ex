defmodule MonobankAPI.Acquiring.Merchants.PaymentInfo do
  @moduledoc """
  Provides struct and type for a Merchants.PaymentInfo
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          basket_order: [MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.t()] | nil,
          comment: String.t() | nil,
          customer_emails: [String.t()] | nil,
          destination: String.t() | nil,
          reference: String.t() | nil
        }
  @type types :: :t

  defstruct [:basket_order, :comment, :customer_emails, :destination, :reference]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      basket_order:
        {"basketOrder", [{MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder, :t}]},
      comment: {"comment", {:string, :generic}},
      customer_emails: {"customerEmails", string: :generic},
      destination: {"destination", {:string, :generic}},
      reference: {"reference", {:string, :generic}}
    ]
  end
end
