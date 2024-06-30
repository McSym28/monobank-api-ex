defmodule MonobankAPI.Acquiring.Wallets.CreatePaymentResponse do
  @moduledoc """
  Provides struct and type for a Wallets.CreatePaymentResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          ccy: integer,
          created_date: DateTime.t(),
          failure_reason: String.t() | nil,
          invoice_id: String.t(),
          modified_date: DateTime.t(),
          status: :failure | :processing | :success | String.t(),
          tds_url: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy, :created_date, :invoice_id, :modified_date, :status]
  defstruct [
    :amount,
    :ccy,
    :created_date,
    :failure_reason,
    :invoice_id,
    :modified_date,
    :status,
    :tds_url
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      ccy: {"ccy", :integer},
      created_date: {"createdDate", {:string, :date_time}},
      failure_reason: {"failureReason", {:string, :generic}},
      invoice_id: {"invoiceId", {:string, :generic}},
      modified_date: {"modifiedDate", {:string, :date_time}},
      status:
        {"status",
         {:enum,
          [{:failure, "failure"}, {:processing, "processing"}, {:success, "success"}, :not_strict]}},
      tds_url: {"tdsUrl", {:string, :generic}}
    ]
  end
end
