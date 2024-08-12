defmodule MonobankAPI.Acquiring.Merchants do
  @moduledoc """
  Provides API endpoints related to merchants
  """

  @base_url "https://api.monobank.ua"

  @doc """
  Дані мерчанта

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get_details([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.DetailsResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get_details(opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/details",
      request_method: :get,
      request_headers: headers,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Merchants.DetailsResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :get_details, []},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Відкритий ключ для верифікації підписів

  Отримання відкритого ключа для перевірки підпису, який включено у вебхуки. Ключ можна кешувати і робити запит на отримання нового, коли верифікація підпису з поточним ключем перестане працювати. Кожного разу робити запит на отримання ключа не треба

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get_pubkey([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.PubkeyResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get_pubkey(opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/pubkey",
      request_method: :get,
      request_headers: headers,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Merchants.PubkeyResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :get_pubkey, []},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Список співробітників


  Список співробітників, які можуть отримати чайові. Для додавання співробітників зверніться в службу турботи. Якщо використовується тестовий токен, то повернуться декілька тестових обʼєктів, які можна буде далі використовувати для налаштовування інтеграції


  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec list_employees([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.Employees.ListResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def list_employees(opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/employee/list",
      request_method: :get,
      request_headers: headers,
      response_types: [
        {200,
         [{"application/json", {MonobankAPI.Acquiring.Merchants.Employees.ListResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :list_employees, []},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Виписка за період

  ## Arguments

    * `from`: utc unix timestamp

  ## Options

    * `to`: utc unix timestamp
    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec list_statements(DateTime.t(), [
          {:to, DateTime.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.StatementsResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def list_statements(from, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    typed_encoder =
      OpenAPIClient.Utils.get_config(
        :acquiring,
        :typed_encoder,
        OpenAPIClient.Client.TypedEncoder
      )

    {:ok, from} =
      typed_encoder.encode(
        from,
        {:integer, "timestamp-s"},
        [{:parameter, :query, "from"}, {"/api/merchant/statement", :get}],
        typed_encoder
      )

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params =
      opts
      |> Keyword.take([:to])
      |> Enum.map(fn {:to, value} ->
        {:ok, value_new} =
          typed_encoder.encode(
            value,
            {:integer, "timestamp-s"},
            [{:parameter, :query, "to"}, [{"/api/merchant/statement", :get}]],
            typed_encoder
          )

        {"to", value_new}
      end)
      |> Map.new()
      |> Map.merge(%{"from" => from})

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/statement",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Merchants.StatementsResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :list_statements, from: from},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Список субмерчантів

  Дане апі потрібне обмеженому колу осіб, яким при створенні рахунку треба явно вказувати термінал

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec list_submerchants([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def list_submerchants(opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/submerchant/list",
      request_method: :get,
      request_headers: headers,
      response_types: [
        {200,
         [{"application/json", {MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :list_submerchants, []},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end
end
