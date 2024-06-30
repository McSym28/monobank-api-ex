defmodule MonobankAPI.Acquiring.Invoices.StatusResponse.WalletData do
  @moduledoc """
  Provides struct and type for a Invoices.StatusResponse.WalletData
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          card_token: String.t(),
          status: :created | :failed | :new | String.t(),
          wallet_id: String.t()
        }
  @type types :: :t

  @enforce_keys [:card_token, :status, :wallet_id]
  defstruct [:card_token, :status, :wallet_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      card_token: {"cardToken", {:string, :generic}},
      status:
        {"status",
         {:enum, [{:created, "created"}, {:failed, "failed"}, {:new, "new"}, :not_strict]}},
      wallet_id: {"walletId", {:string, :generic}}
    ]
  end
end
