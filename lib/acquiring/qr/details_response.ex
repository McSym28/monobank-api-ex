defmodule MonobankAPI.Acquiring.QR.DetailsResponse do
  @moduledoc """
  Provides struct and type for a QR.DetailsResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount: integer | nil,
          ccy: integer | nil,
          invoice_id: String.t() | nil,
          short_qr_id: String.t()
        }
  @type types :: :t

  @enforce_keys [:short_qr_id]
  defstruct [:amount, :ccy, :invoice_id, :short_qr_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount: {"amount", {:integer, :int64}},
      ccy: {"ccy", {:integer, :int32}},
      invoice_id: {"invoiceId", {:string, :generic}},
      short_qr_id: {"shortQrId", {:string, :generic}}
    ]
  end
end
