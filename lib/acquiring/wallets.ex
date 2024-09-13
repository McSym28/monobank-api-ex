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
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec create_payment(MonobankAPI.Acquiring.Wallets.CreatePaymentRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Wallets.CreatePaymentResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def create_payment(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/wallet/payment",
        method: :post,
        request_parameter_types: [
          {{:cms, :header},
           {"X-Cms", {:string, :generic}, fn -> Application.get_env(:monobank_api_ex, :cms) end}},
          {{:cms_version, :header},
           {"X-Cms-Version", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :cms_version) end}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        request_types: [
          {"application/json", {MonobankAPI.Acquiring.Wallets.CreatePaymentRequest, :t}}
        ],
        response_types: [
          {200,
           [{"application/json", {MonobankAPI.Acquiring.Wallets.CreatePaymentResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :create_payment},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Видалення токенізованої картки

  ## Arguments

    * `card_token`: ["cardToken"] Токен картки

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec delete_card(String.t(), [
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
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def delete_card(card_token, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/wallet/card",
        method: :delete,
        request_parameter_types: [
          {{:card_token, :query}, {"cardToken", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", :map}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [card_token: card_token],
        function_call: {__MODULE__, :delete_card},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Список карток у гаманці

  ## Arguments

    * `wallet_id`: ["walletId"] Ідентифікатор гаманця покупця

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Wallets.GetResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get(wallet_id, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/wallet",
        method: :get,
        request_parameter_types: [
          {{:wallet_id, :query}, {"walletId", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Wallets.GetResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [wallet_id: wallet_id],
        function_call: {__MODULE__, :get},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end
end
