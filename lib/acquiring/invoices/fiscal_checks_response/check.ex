defmodule MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.Check do
  @moduledoc """
  Provides struct and type for a Invoices.FiscalChecksResponse.Check
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          file: String.t() | nil,
          fiscalization_source: :checkbox | :monopay | String.t(),
          id: String.t(),
          status: :done | :failed | :new | :process | String.t(),
          status_description: String.t() | nil,
          tax_url: String.t() | nil,
          type: :return | :sale | String.t()
        }
  @type types :: :t

  @enforce_keys [:fiscalization_source, :id, :status, :type]
  defstruct [:file, :fiscalization_source, :id, :status, :status_description, :tax_url, :type]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      file: {"file", {:string, :generic}},
      fiscalization_source:
        {"fiscalizationSource",
         {:enum, [{:checkbox, "checkbox"}, {:monopay, "monopay"}, :not_strict]}},
      id: {"id", {:string, :generic}},
      status:
        {"status",
         {:enum,
          [
            {:done, "done"},
            {:failed, "failed"},
            {:new, "new"},
            {:process, "process"},
            :not_strict
          ]}},
      status_description: {"statusDescription", {:string, :generic}},
      tax_url: {"taxUrl", {:string, :generic}},
      type: {"type", {:enum, [{:return, "return"}, {:sale, "sale"}, :not_strict]}}
    ]
  end
end
