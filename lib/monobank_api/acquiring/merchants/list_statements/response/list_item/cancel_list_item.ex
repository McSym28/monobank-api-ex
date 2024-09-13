defmodule MonobankAPI.Acquiring.Merchants.ListStatements.Response.ListItem.CancelListItem do
  @moduledoc """
  Provides struct and type for a Merchants.ListStatements.Response.ListItem.CancelListItem
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer,
          approval_code: String.t() | nil,
          ccy: integer,
          date: DateTime.t(),
          masked_pan: String.t(),
          rrn: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:amount, :ccy, :date, :masked_pan]
  defstruct [:amount, :approval_code, :ccy, :date, :masked_pan, :rrn]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      approval_code: {"approvalCode", {:string, :generic}},
      ccy: {"ccy", {:integer, :int32}},
      date: {"date", {:string, :date_time}},
      masked_pan: {"maskedPan", {:string, :generic}},
      rrn: {"rrn", {:string, :generic}}
    ]
  end
end
