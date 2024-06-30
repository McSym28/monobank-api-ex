defmodule MonobankAPI.Acquiring.Merchants.StatementsResponse do
  @moduledoc """
  Provides struct and type for a Merchants.StatementsResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          list: [MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem.t()] | nil
        }
  @type types :: :t

  defstruct [:list]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [list: {"list", [{MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem, :t}]}]
  end
end
