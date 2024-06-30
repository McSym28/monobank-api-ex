defmodule MonobankAPI.Acquiring.Merchants.Employees.ListResponse.Item do
  @moduledoc """
  Provides struct and type for a Merchants.Employees.ListResponse.Item
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{ext_ref: String.t(), id: String.t(), name: String.t()}
  @type types :: :t

  @enforce_keys [:ext_ref, :id, :name]
  defstruct [:ext_ref, :id, :name]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      ext_ref: {"extRef", {:string, :generic}},
      id: {"id", {:string, :generic}},
      name: {"name", {:string, :generic}}
    ]
  end
end
