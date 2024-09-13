defmodule MonobankAPI.Acquiring.QR do
  @moduledoc """
  Provides API endpoints related to qr
  """

  @base_url "https://api.monobank.ua"

  @doc """
  Інформація про QR-касу

  Інформація про QR-касу, лише для активованих QR-кас

  ## Arguments

    * `qr_id`: ["qrId"] Ідентифікатор QR-каси

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get_details(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.QR.Details.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get_details(qr_id, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/qr/details",
        method: :get,
        request_parameter_types: [
          {{:qr_id, :query}, {"qrId", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.QR.Details.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [qr_id: qr_id],
        function_call: {__MODULE__, :get_details},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Список QR-кас

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec list([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.QR.List.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def list(opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/qr/list",
        method: :get,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.QR.List.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [],
        function_call: {__MODULE__, :list},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Видалення суми оплати

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec reset_amount(MonobankAPI.Acquiring.QR.ResetAmount.Request.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, map}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def reset_amount(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/qr/reset-amount",
        method: :post,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        request_types: [{"application/json", {MonobankAPI.Acquiring.QR.ResetAmount.Request, :t}}],
        response_types: [
          {200, [{"application/json", :map}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :reset_amount},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end
end
