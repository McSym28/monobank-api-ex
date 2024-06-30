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
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get_details(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.QR.DetailsResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get_details(qr_id, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"qrId" => qr_id}
    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/qr/details",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.QR.DetailsResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :get_details, qr_id: qr_id},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Список QR-кас

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec list([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.QR.ListResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def list(opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/qr/list",
      request_method: :get,
      request_headers: headers,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.QR.ListResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :list, []},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Видалення суми оплати

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec reset_amount(MonobankAPI.Acquiring.QR.ResetAmountRequest.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, map}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def reset_amount(body, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/qr/reset-amount",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [{"application/json", {MonobankAPI.Acquiring.QR.ResetAmountRequest, :t}}],
      response_types: [
        {200, [{"application/json", :map}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :reset_amount, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end
end
