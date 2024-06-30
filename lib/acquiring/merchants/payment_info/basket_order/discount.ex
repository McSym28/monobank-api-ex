defmodule MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount do
  @moduledoc """
  Provides struct and type for a Merchants.PaymentInfo.BasketOrder.Discount
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          mode: :percent | :value | String.t(),
          type: :discount | :extra_charge | String.t(),
          value: number
        }
  @type types :: :t

  @enforce_keys [:mode, :type, :value]
  defstruct [:mode, :type, :value]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      mode: {"mode", {:enum, [{:percent, "PERCENT"}, {:value, "VALUE"}, :not_strict]}},
      type:
        {"type", {:enum, [{:discount, "DISCOUNT"}, {:extra_charge, "EXTRA_CHARGE"}, :not_strict]}},
      value: {"value", :number}
    ]
  end
end
