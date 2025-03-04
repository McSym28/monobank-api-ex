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
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get_details() ::
          {:ok, MonobankAPI.Acquiring.Merchants.Details.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  @spec get_details([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
          | {:client, module()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.Details.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get_details(opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/details",
        method: :get,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Merchants.Details.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [],
        function_call: {__MODULE__, :get_details},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Відкритий ключ для верифікації підписів

  Отримання відкритого ключа для перевірки підпису, який включено у вебхуки. Ключ можна кешувати і робити запит на отримання нового, коли верифікація підпису з поточним ключем перестане працювати. Кожного разу робити запит на отримання ключа не треба

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get_pubkey() ::
          {:ok, MonobankAPI.Acquiring.Merchants.Pubkey.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  @spec get_pubkey([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
          | {:client, module()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.Pubkey.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get_pubkey(opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/pubkey",
        method: :get,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Merchants.Pubkey.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [],
        function_call: {__MODULE__, :get_pubkey},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Список співробітників


  Список співробітників, які можуть отримати чайові. Для додавання співробітників зверніться в службу турботи. Якщо використовується тестовий токен, то повернуться декілька тестових обʼєктів, які можна буде далі використовувати для налаштовування інтеграції


  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec list_employees() ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListEmployees.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  @spec list_employees([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
          | {:client, module()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListEmployees.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def list_employees(opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/employee/list",
        method: :get,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200,
           [{"application/json", {MonobankAPI.Acquiring.Merchants.ListEmployees.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [],
        function_call: {__MODULE__, :list_employees},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Виписка за період

  ## Arguments

    * `from`: utc unix timestamp

  ## Options

    * `code`: Ідентифікатор терміналу субмерчанту (використовується, якщо мерчант має субмерчантів)
    * `to`: utc unix timestamp
    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec list_statements(DateTime.t()) ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListStatements.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  @spec list_statements(DateTime.t(), [
          {:code, String.t()}
          | {:to, DateTime.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
          | {:client, module()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListStatements.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def list_statements(from, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/statement",
        method: :get,
        request_parameter_types: [
          {{:from, :query}, {"from", {:integer, "timestamp-s"}}},
          {{:code, :query}, {"code", {:string, :generic}}},
          {{:to, :query}, {"to", {:integer, "timestamp-s"}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200,
           [{"application/json", {MonobankAPI.Acquiring.Merchants.ListStatements.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [from: from],
        function_call: {__MODULE__, :list_statements},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Список субмерчантів

  Дане апі потрібне обмеженому колу осіб, яким при створенні рахунку треба явно вказувати термінал

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec list_submerchants() ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  @spec list_submerchants([
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
          | {:client, module()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def list_submerchants(opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/submerchant/list",
        method: :get,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200,
           [{"application/json", {MonobankAPI.Acquiring.Merchants.ListSubmerchants.Response, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [],
        function_call: {__MODULE__, :list_submerchants},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end
end
