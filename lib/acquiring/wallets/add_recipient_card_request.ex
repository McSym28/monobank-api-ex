defmodule MonobankAPI.Acquiring.Wallets.AddRecipientCardRequest do
  @moduledoc """
  Provides struct and type for a Wallets.AddRecipientCardRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          exp: String.t(),
          pan: String.t(),
          recipient_first_name: String.t(),
          recipient_last_name: String.t(),
          wallet_id: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:exp, :pan, :recipient_first_name, :recipient_last_name]
  defstruct [:exp, :pan, :recipient_first_name, :recipient_last_name, :wallet_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      exp: {"exp", {:string, :generic}},
      pan: {"pan", {:string, :generic}},
      recipient_first_name: {"recipientFirstName", {:string, :generic}},
      recipient_last_name: {"recipientLastName", {:string, :generic}},
      wallet_id: {"walletId", {:string, :generic}}
    ]
  end
end
