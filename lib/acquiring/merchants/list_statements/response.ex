defmodule MonobankAPI.Acquiring.Merchants.ListStatements.Response do
  @moduledoc """
  Provides struct and type for a Merchants.ListStatements.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          list: [MonobankAPI.Acquiring.Merchants.ListStatements.Response.ListItem.t()] | nil
        }
  @type types :: :t

  defstruct [:list]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [list: {"list", [{MonobankAPI.Acquiring.Merchants.ListStatements.Response.ListItem, :t}]}]
  end
end
