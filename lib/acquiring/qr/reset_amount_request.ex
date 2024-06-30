defmodule MonobankAPI.Acquiring.QR.ResetAmountRequest do
  @moduledoc """
  Provides struct and type for a QR.ResetAmountRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{qr_id: String.t()}
  @type types :: :t

  @enforce_keys [:qr_id]
  defstruct [:qr_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [qr_id: {"qrId", {:string, :generic}}]
  end
end
