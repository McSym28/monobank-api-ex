defmodule MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse do
  @moduledoc """
  Provides struct and type for a Merchants.Submerchants.ListResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          list: [MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse.Item.t()] | nil
        }
  @type types :: :t

  defstruct [:list]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [list: {"list", [{MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse.Item, :t}]}]
  end
end
