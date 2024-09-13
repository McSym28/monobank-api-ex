defmodule MonobankAPI.Acquiring.Invoices.Status.Response.TipsInfo do
  @moduledoc """
  Provides struct and type for a Invoices.Status.Response.TipsInfo
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{amount: integer | nil, employee_id: String.t()}
  @type types :: :t

  @enforce_keys [:employee_id]
  defstruct [:amount, :employee_id]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [amount: {"amount", :integer}, employee_id: {"employeeId", {:string, :generic}}]
  end
end
