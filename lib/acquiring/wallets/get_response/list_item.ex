defmodule MonobankAPI.Acquiring.Wallets.GetResponse.ListItem do
  @moduledoc """
  Provides struct and type for a Wallets.GetResponse.ListItem
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          card_token: String.t(),
          country: String.t() | nil,
          masked_pan: String.t()
        }
  @type types :: :t

  @enforce_keys [:card_token, :masked_pan]
  defstruct [:card_token, :country, :masked_pan]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      card_token: {"cardToken", {:string, :generic}},
      country: {"country", {:string, :generic}},
      masked_pan: {"maskedPan", {:string, :generic}}
    ]
  end
end
