defmodule MonobankAPI.Acquiring.Invoices.CreateSyncPayment.Request.ApplePay do
  @moduledoc """
  Provides struct and type for a Invoices.CreateSyncPayment.Request.ApplePay
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          cryptogram: String.t() | nil,
          eci_indicator: String.t(),
          exp: String.t(),
          token: String.t()
        }
  @type types :: :t

  @enforce_keys [:eci_indicator, :exp, :token]
  defstruct [:cryptogram, :eci_indicator, :exp, :token]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [
      cryptogram: {"cryptogram", {:string, :generic}},
      eci_indicator: {"eciIndicator", {:string, :generic}},
      exp: {"exp", {:string, :generic}},
      token: {"token", {:string, :generic}}
    ]
  end
end
