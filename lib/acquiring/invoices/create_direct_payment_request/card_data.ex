defmodule MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData do
  @moduledoc """
  Provides struct and type for a Invoices.CreateDirectPaymentRequest.CardData
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{cvv: String.t(), exp: String.t(), pan: String.t()}
  @type types :: :t

  @enforce_keys [:cvv, :exp, :pan]
  defstruct [:cvv, :exp, :pan]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      cvv: {"cvv", {:string, :generic}},
      exp: {"exp", {:string, :generic}},
      pan: {"pan", {:string, :generic}}
    ]
  end
end
