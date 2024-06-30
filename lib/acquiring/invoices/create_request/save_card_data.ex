defmodule MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData do
  @moduledoc """
  Provides struct and type for a Invoices.CreateRequest.SaveCardData
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{save_card: boolean, wallet_id: String.t() | nil}
  @type types :: :t

  @enforce_keys [:save_card]
  defstruct [:save_card, :wallet_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [save_card: {"saveCard", :boolean}, wallet_id: {"walletId", {:string, :generic}}]
  end
end
