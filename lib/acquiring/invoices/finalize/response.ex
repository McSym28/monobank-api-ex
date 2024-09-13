defmodule MonobankAPI.Acquiring.Invoices.Finalize.Response do
  @moduledoc """
  Provides struct and type for a Invoices.Finalize.Response
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{status: :success | String.t()}
  @type types :: :t

  @enforce_keys [:status]
  defstruct [:status]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.field_type())
  def __fields__(:t) do
    [status: {"status", {:enum, [{:success, "success"}, :not_strict]}}]
  end
end
