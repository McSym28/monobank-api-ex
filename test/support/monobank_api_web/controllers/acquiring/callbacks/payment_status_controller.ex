defmodule MonobankAPIWeb.Acquiring.Callbacks.PaymentStatusController do
  use MonobankAPIWeb, :controller

  plug(OpenAPIClient.Plugs.CallbackInitializer,
    implementation: {:mock, MonobankAPI.Acquiring.CallbacksMock},
    behaviour: MonobankAPI.Acquiring.Callbacks,
    function_name: :payment_status
  )

  plug(OpenAPIClient.Plugs.RequestTypedDecoder)
  plug(MonobankAPI.Plugs.Acquiring.WebhookSignatureChecker)
  plug(OpenAPIClient.Plugs.FunctionCallDecoder)
  plug(OpenAPIClient.Plugs.FunctionCall)
  plug(OpenAPIClient.Plugs.FunctionResultEncoder)
  plug(OpenAPIClient.Plugs.ResponseTypedEncoder)
  plug(OpenAPIClient.Plugs.ResponseSerializers, serializers: [json: [json_encoder: Jason]])

  @spec payment_status(conn :: Plug.Conn.t(), params :: Plug.Conn.params()) :: Plug.Conn.t()
  def payment_status(conn, _params) do
    Plug.Conn.send_resp(conn)
  end
end
