defmodule MonobankAPI.Acquiring.Wallets.GetResponse do
  @moduledoc """
  Provides struct and type for a Wallets.GetResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{wallet: [MonobankAPI.Acquiring.Wallets.GetResponse.ListItem.t()]}
  @type types :: :t

  @enforce_keys [:wallet]
  defstruct [:wallet]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [wallet: {"wallet", [{MonobankAPI.Acquiring.Wallets.GetResponse.ListItem, :t}]}]
  end
end
