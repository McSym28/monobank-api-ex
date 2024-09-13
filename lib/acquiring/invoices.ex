defmodule MonobankAPI.Acquiring.Invoices do
  @moduledoc """
  Provides API endpoints related to invoices
  """

  @base_url "https://api.monobank.ua"

  @doc """
  Скасування оплати

  Скасування успішної оплати рахунку

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec cancel(MonobankAPI.Acquiring.Invoices.CancelRequest.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.CancelResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def cancel(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/cancel",
        method: :post,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.CancelRequest, :t}}],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.CancelResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :cancel},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Створення рахунку

  Створення рахунку для оплати

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
  @spec create(MonobankAPI.Acquiring.Invoices.CreateRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.CreateResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def create(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/create",
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
        request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.CreateRequest, :t}}],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.CreateResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :create},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Оплата за реквізитами

  Створення рахунку та його оплата за реквізитами картки. Увага, це апі буде працювати тільки за умови наявності у мерчанта активного PCI DSS сертифіката!

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
  @spec create_direct_payment(MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.t(), [
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
  def create_direct_payment(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/payment-direct",
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
          {"application/json", {MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest, :t}}
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
        function_call: {__MODULE__, :create_direct_payment},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Синхронна оплата

  Апі для синхронної оплати, доступ до апі надається через службу турботи та вимагає наявності певного ряду сертифікатів. Один із обʼєктів `cardData`, `applePay`, `googlePay` є обовʼязковим

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
  @spec create_sync_payment(MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.StatusResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def create_sync_payment(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/sync-payment",
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
          {"application/json", {MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest, :t}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.StatusResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :create_sync_payment},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Фіналізація суми холду

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec finalize(MonobankAPI.Acquiring.Invoices.FinalizeRequest.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.FinalizeResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def finalize(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/finalize",
        method: :post,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        request_types: [
          {"application/json", {MonobankAPI.Acquiring.Invoices.FinalizeRequest, :t}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.FinalizeResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [body: body],
        function_call: {__MODULE__, :finalize},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Квитанція

  Метод для отримання та відправки квитанції на електронну пошту

  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `email`: Адреса електронної пошти
    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get_receipts(String.t(), [
          {:email, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.ReceiptResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get_receipts(invoice_id, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/receipt",
        method: :get,
        request_parameter_types: [
          {{:invoice_id, :query}, {"invoiceId", {:string, :generic}}},
          {{:email, :query}, {"email", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.ReceiptResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [invoice_id: invoice_id],
        function_call: {__MODULE__, :get_receipts},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Статус рахунку

  Метод перевірки статусу рахунку при розсинхронізації з боку продавця або відсутності webHookUrl при створенні рахунку.

  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec get_status(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.StatusResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def get_status(invoice_id, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/status",
        method: :get,
        request_parameter_types: [
          {{:invoice_id, :query}, {"invoiceId", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.StatusResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [invoice_id: invoice_id],
        function_call: {__MODULE__, :get_status},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Фіскальні чеки

  Метод для отримання даних фіскальних чеків та їх статусів

  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec list_fiscal_checks(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:pipeline, OpenAPIClient.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Error.t()}
  def list_fiscal_checks(invoice_id, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/fiscal-checks",
        method: :get,
        request_parameter_types: [
          {{:invoice_id, :query}, {"invoiceId", {:string, :generic}}},
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        response_types: [
          {200,
           [{"application/json", {MonobankAPI.Acquiring.Invoices.FiscalChecksResponse, :t}}]},
          {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
          {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
          {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
          {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
          {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
          {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
        ],
        function_args: [invoice_id: invoice_id],
        function_call: {__MODULE__, :list_fiscal_checks},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end

  @doc """
  Інвалідація рахунку

  Інвалідація рахунку, якщо за ним ще не було здіснено оплати

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `pipeline`: Operation pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)}
    * `client`: Module that implements `OpenAPIClient` behaviour. Default value obtained through a call to `OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)`

  """
  @spec remove(MonobankAPI.Acquiring.Invoices.RemoveRequest.t(), [
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
  def remove(body, opts \\ []) do
    pipeline = opts[:pipeline] || OpenAPIClient.Utils.get_config(:acquiring, :operation_pipeline)
    base_url = opts[:base_url] || @base_url
    client = opts[:client] || OpenAPIClient.Utils.get_config(:acquiring, :client, OpenAPIClient)

    client.operation(
      %OpenAPIClient.State{
        request_base_url: base_url,
        request_path: "/api/merchant/invoice/remove",
        method: :post,
        request_parameter_types: [
          {{:token, :header},
           {"X-Token", {:string, :generic},
            fn -> Application.get_env(:monobank_api_ex, :token) end}}
        ],
        request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.RemoveRequest, :t}}],
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
        function_call: {__MODULE__, :remove},
        function_opts: opts,
        profile: :acquiring
      },
      pipeline
    )
  end
end
