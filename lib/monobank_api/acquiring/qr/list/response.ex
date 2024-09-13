defmodule MonobankAPI.Acquiring.QR.List.Response do
  @moduledoc """
  Provides struct and type for a QR.List.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{list: [MonobankAPI.Acquiring.QR.List.Response.Item.t()] | nil}
  @type types :: :t

  defstruct [:list]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [list: {"list", [{MonobankAPI.Acquiring.QR.List.Response.Item, :t}]}]
  end
end
