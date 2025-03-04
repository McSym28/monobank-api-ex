defmodule MonobankAPI.Acquiring.Callbacks do
  @moduledoc """
  Provides API callback related to callbacks
  """

  @behaviour OpenAPIClient.Callback

  @type callback_functions :: :payment_status

  @doc """
  Дані про стан платежу при кожній зміні статусу

  Дані про стан платежу

  ## Arguments

    * `body`

  """
  @callback payment_status(MonobankAPI.Acquiring.Invoices.Status.Response.t()) ::
              :ok | {:error, OpenAPIClient.Error.t()}

  @optional_callbacks payment_status: 1

  @doc false
  @impl OpenAPIClient.Callback
  @spec __functions__(callback_functions()) :: [OpenAPIClient.Callback.function_option()]
  def __functions__(:payment_status) do
    [
      request_path_mask: "/{*request.body.webHookUrl*}",
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.Status.Response, :t}}],
      response_types: [{200, :null}],
      profile: :acquiring
    ]
  end
end
