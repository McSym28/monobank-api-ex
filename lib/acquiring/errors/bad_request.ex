defmodule MonobankAPI.Acquiring.Errors.BadRequest do
  @moduledoc """
  Provides struct and type for a Errors.BadRequest
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{err_code: String.t(), err_text: String.t()}
  @type types :: :t

  @enforce_keys [:err_code, :err_text]
  defstruct [:err_code, :err_text]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [err_code: {"errCode", {:string, :generic}}, err_text: {"errText", {:string, :generic}}]
  end
end
