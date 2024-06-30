defmodule MonobankAPI.Acquiring.QR.ListResponse.Item do
  @moduledoc """
  Provides struct and type for a QR.ListResponse.Item
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          amount_type: :client | :fix | :merchant | String.t(),
          page_url: String.t(),
          qr_id: String.t(),
          short_qr_id: String.t()
        }
  @type types :: :t

  @enforce_keys [:amount_type, :page_url, :qr_id, :short_qr_id]
  defstruct [:amount_type, :page_url, :qr_id, :short_qr_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      amount_type:
        {"amountType",
         {:enum, [{:client, "client"}, {:fix, "fix"}, {:merchant, "merchant"}, :not_strict]}},
      page_url: {"pageUrl", {:string, :generic}},
      qr_id: {"qrId", {:string, :generic}},
      short_qr_id: {"shortQrId", {:string, :generic}}
    ]
  end
end
