defmodule MonobankAPI.Acquiring.Wallets.AddRecipientCardResponse do
  @moduledoc """
  Provides struct and type for a Wallets.AddRecipientCardResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{card_token: String.t(), wallet_id: String.t()}
  @type types :: :t

  @enforce_keys [:card_token, :wallet_id]
  defstruct [:card_token, :wallet_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [card_token: {"cardToken", {:string, :generic}}, wallet_id: {"walletId", {:string, :generic}}]
  end
end
