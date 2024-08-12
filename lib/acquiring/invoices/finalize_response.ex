defmodule MonobankAPI.Acquiring.Invoices.FinalizeResponse do
  @moduledoc """
  Provides struct and type for a Invoices.FinalizeResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{status: :success | String.t()}
  @type types :: :t

  @enforce_keys [:status]
  defstruct [:status]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [status: {"status", {:enum, [{:success, "success"}, :not_strict]}}]
  end
end
