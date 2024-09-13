defmodule MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response do
  @moduledoc """
  Provides struct and type for a Merchants.ListSubmerchants.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          list: [MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response.Item.t()] | nil
        }
  @type types :: :t

  defstruct [:list]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [list: {"list", [{MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response.Item, :t}]}]
  end
end
