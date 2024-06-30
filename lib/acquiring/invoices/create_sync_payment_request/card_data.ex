defmodule MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData do
  @moduledoc """
  Provides struct and type for a Invoices.CreateSyncPaymentRequest.CardData
  """

  @behaviour OpenAPIClient.Schema

  @type t :: %__MODULE__{
          cavv: String.t() | nil,
          cvv: String.t() | nil,
          ds_tran_id: String.t() | nil,
          eci_indicator: String.t(),
          exp: String.t(),
          mit: String.t() | nil,
          pan: String.t(),
          sst: number | nil,
          t_req_id: String.t() | nil,
          tavv: String.t() | nil,
          tid: String.t() | nil,
          type: :dpan | :fpan | String.t()
        }
  @type types :: :t

  @enforce_keys [:eci_indicator, :exp, :pan, :type]
  defstruct [
    :cavv,
    :cvv,
    :ds_tran_id,
    :eci_indicator,
    :exp,
    :mit,
    :pan,
    :sst,
    :t_req_id,
    :tavv,
    :tid,
    :type
  ]

  @doc false
  @impl OpenAPIClient.Schema
  @spec __fields__(types()) :: keyword(OpenAPIClient.Schema.schema_type())
  def __fields__(:t) do
    [
      cavv: {"cavv", {:string, :generic}},
      cvv: {"cvv", {:string, :generic}},
      ds_tran_id: {"dsTranId", {:string, :generic}},
      eci_indicator: {"eciIndicator", {:string, :generic}},
      exp: {"exp", {:string, :generic}},
      mit: {"mit", {:string, :generic}},
      pan: {"pan", {:string, :generic}},
      sst: {"sst", :number},
      t_req_id: {"tReqID", {:string, :generic}},
      tavv: {"tavv", {:string, :generic}},
      tid: {"tid", {:string, :generic}},
      type: {"type", {:enum, [{:dpan, "DPAN"}, {:fpan, "FPAN"}, :not_strict]}}
    ]
  end
end
