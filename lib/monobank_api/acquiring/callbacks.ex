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

    * `x_sign`: ["X-Sign"] Підпис тіла запиту вебхуку по стандарту ECDSA
    * `body`

  """
  @callback payment_status(
              String.t(),
              MonobankAPI.Acquiring.Invoices.Status.Response.t(),
              keyword
            ) :: :ok | {:error, OpenAPIClient.Error.t()}

  @optional_callbacks payment_status: 3

  @doc false
  @impl OpenAPIClient.Callback
  @spec __functions__(callback_functions()) :: [OpenAPIClient.Callback.function_option()]
  def __functions__(:payment_status) do
    [
      request_path_mask: "/{*request.body.webHookUrl*}",
      request_parameter_types: [{{:x_sign, :header}, {"X-Sign", {:string, :generic}}}],
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.Status.Response, :t}}],
      response_types: [{200, :null}],
      request_parameter_args: [:x_sign],
      profile: :acquiring
    ]
  end
end
