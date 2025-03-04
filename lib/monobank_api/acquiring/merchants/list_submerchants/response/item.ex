defmodule MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response.Item do
  @moduledoc """
  Provides struct and type for a Merchants.ListSubmerchants.Response.Item
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          code: String.t(),
          edrpou: String.t() | nil,
          iban: String.t(),
          owner: String.t() | nil
        }
  @type types :: :t

  @enforce_keys [:code, :iban]
  defstruct [:code, :edrpou, :iban, :owner]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      code: {"code", {:string, :generic}},
      edrpou: {"edrpou", {:string, :generic}},
      iban: {"iban", {:string, :generic}},
      owner: {"owner", {:string, :generic}}
    ]
  end
end
