defmodule MonobankAPI.Acquiring.Wallets.Get.Response do
  @moduledoc """
  Provides struct and type for a Wallets.Get.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{wallet: [MonobankAPI.Acquiring.Wallets.Get.Response.ListItem.t()]}
  @type types :: :t

  @enforce_keys [:wallet]
  defstruct [:wallet]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [wallet: {"wallet", [{MonobankAPI.Acquiring.Wallets.Get.Response.ListItem, :t}]}]
  end
end
