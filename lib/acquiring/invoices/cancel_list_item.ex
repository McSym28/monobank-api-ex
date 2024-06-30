defmodule MonobankAPI.Acquiring.Invoices.CancelListItem do
  @moduledoc """
  Provides struct and type for a Invoices.CancelListItem
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer | nil,
          approval_code: String.t() | nil,
          ccy: integer | nil,
          created_date: DateTime.t(),
          ext_ref: String.t() | nil,
          modified_date: DateTime.t(),
          rrn: String.t() | nil,
          status: :failure | :processing | :success | String.t()
        }
  @type types :: :t

  @enforce_keys [:created_date, :modified_date, :status]
  defstruct [
    :amount,
    :approval_code,
    :ccy,
    :created_date,
    :ext_ref,
    :modified_date,
    :rrn,
    :status
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", :integer},
      approval_code: {"approvalCode", {:string, :generic}},
      ccy: {"ccy", :integer},
      created_date: {"createdDate", {:string, :date_time}},
      ext_ref: {"extRef", {:string, :generic}},
      modified_date: {"modifiedDate", {:string, :date_time}},
      rrn: {"rrn", {:string, :generic}},
      status:
        {"status",
         {:enum,
          [{:failure, "failure"}, {:processing, "processing"}, {:success, "success"}, :not_strict]}}
    ]
  end
end
