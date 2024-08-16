defmodule MonobankAPI.Acquiring.Wallets do
  @moduledoc """
  Provides API endpoints related to wallets
  """

  @base_url "https://api.monobank.ua"

  @doc """
  Оплата по токену

  Створення платежу за токеном картки

  ## Arguments

    * `body`

  ## Options

    * `cms`: ["X-Cms"] Назва CMS, якщо ви розробляєте платіжний модуль для CMS. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :cms)`
    * `cms_version`: ["X-Cms-Version"] Версія CMS, якщо ви розробляєте платіжний модуль для CMS. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :cms_version)`
    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec create_payment(MonobankAPI.Acquiring.Wallets.CreatePaymentRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Wallets.CreatePaymentResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def create_payment(body, opts \\ []) do
    initial_args = [body: body]

    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url
    cms = Keyword.get_lazy(opts, :cms, fn -> Application.get_env(:monobank_api_ex, :cms) end)

    cms_version =
      Keyword.get_lazy(opts, :cms_version, fn ->
        Application.get_env(:monobank_api_ex, :cms_version)
      end)

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Cms" => cms, "X-Cms-Version" => cms_version, "X-Token" => token}
    client = OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient.Client)

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/wallet/payment",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [
        {"application/json", {MonobankAPI.Acquiring.Wallets.CreatePaymentRequest, :t}}
      ],
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Wallets.CreatePaymentResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __args__: initial_args,
      __call__: {__MODULE__, :create_payment},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> client.perform(client_pipeline)
  end

  @doc """
  Видалення токенізованої картки

  ## Arguments

    * `card_token`: ["cardToken"] Токен картки

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec delete_card(String.t(), [
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
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def delete_card(card_token, opts \\ []) do
    initial_args = [card_token: card_token]

    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"cardToken" => card_token}
    headers = %{"X-Token" => token}
    client = OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient.Client)

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/wallet/card",
      request_method: :delete,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", :map}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __args__: initial_args,
      __call__: {__MODULE__, :delete_card},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> client.perform(client_pipeline)
  end

  @doc """
  Список карток у гаманці

  ## Arguments

    * `wallet_id`: ["walletId"] Ідентифікатор гаманця покупця

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Wallets.GetResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get(wallet_id, opts \\ []) do
    initial_args = [wallet_id: wallet_id]

    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"walletId" => wallet_id}
    headers = %{"X-Token" => token}
    client = OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient.Client)

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/wallet",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Wallets.GetResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __args__: initial_args,
      __call__: {__MODULE__, :get},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> client.perform(client_pipeline)
  end
end
