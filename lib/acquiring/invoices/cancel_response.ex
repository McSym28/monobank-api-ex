defmodule MonobankAPI.Acquiring.Invoices.CancelResponse do
  @moduledoc """
  Provides struct and type for a Invoices.CancelResponse
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          created_date: DateTime.t(),
          modified_date: DateTime.t(),
          status: :failure | :processing | :success | String.t()
        }
  @type types :: :t

  @enforce_keys [:created_date, :modified_date, :status]
  defstruct [:created_date, :modified_date, :status]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      created_date: {"createdDate", {:string, :date_time}},
      modified_date: {"modifiedDate", {:string, :date_time}},
      status:
        {"status",
         {:enum,
          [{:failure, "failure"}, {:processing, "processing"}, {:success, "success"}, :not_strict]}}
    ]
  end
end
