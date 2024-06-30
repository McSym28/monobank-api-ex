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
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec cancel(MonobankAPI.Acquiring.Invoices.CancelRequest.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.CancelResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def cancel(body, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/cancel",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.CancelRequest, :t}}],
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.CancelResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :cancel, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
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
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec create(MonobankAPI.Acquiring.Invoices.CreateRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.CreateResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def create(body, opts \\ []) do
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

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/create",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.CreateRequest, :t}}],
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.CreateResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :create, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
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
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec create_direct_payment(MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.t(), [
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
  def create_direct_payment(body, opts \\ []) do
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

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/payment-direct",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [
        {"application/json", {MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest, :t}}
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
      __info__: {__MODULE__, :create_direct_payment, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
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
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec create_sync_payment(MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.t(), [
          {:cms, String.t()}
          | {:cms_version, String.t()}
          | {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.StatusResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def create_sync_payment(body, opts \\ []) do
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

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/sync-payment",
      request_body: body,
      request_method: :post,
      request_headers: headers,
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
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :create_sync_payment, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Фіналізація суми холду

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec finalize(MonobankAPI.Acquiring.Invoices.FinalizeRequest.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.FinalizeResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def finalize(body, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/finalize",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.FinalizeRequest, :t}}],
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.FinalizeResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :finalize, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  DEPRECATED — Розширена інформація про успішну оплату


  **Дане апі застаріле! Слід використовувати Статус рахунку, замість цього апі** 

  Дані про успішну оплату, якщо вона була здійснена


  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get_payment_info(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.PaymentInfoResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get_payment_info(invoice_id, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"invoiceId" => invoice_id}
    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/payment-info",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.PaymentInfoResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :get_payment_info, invoice_id: invoice_id},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Статус рахунку

  Метод перевірки статусу рахунку при розсинхронізації з боку продавця або відсутності webHookUrl при створенні рахунку.

  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec get_status(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.StatusResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def get_status(invoice_id, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"invoiceId" => invoice_id}
    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/status",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.StatusResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :get_status, invoice_id: invoice_id},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Фіскальні чеки

  Метод для отримання даних фіскальних чеків та їх статусів

  ## Arguments

    * `invoice_id`: ["invoiceId"] Ідентифікатор рахунку

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec list_fiscal_checks(String.t(), [
          {:token, String.t()}
          | {:base_url, String.t() | URI.t()}
          | {:client_pipeline, OpenAPIClient.Client.pipeline()}
        ]) ::
          {:ok, MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.t()}
          | {:error,
             MonobankAPI.Acquiring.Errors.BadRequest.t()
             | MonobankAPI.Acquiring.Errors.Forbidden.t()
             | MonobankAPI.Acquiring.Errors.InternalServer.t()
             | MonobankAPI.Acquiring.Errors.MethodNotAllowed.t()
             | MonobankAPI.Acquiring.Errors.NotFound.t()
             | MonobankAPI.Acquiring.Errors.TooManyRequests.t()
             | OpenAPIClient.Client.Error.t()}
  def list_fiscal_checks(invoice_id, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    query_params = %{"invoiceId" => invoice_id}
    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/fiscal-checks",
      request_method: :get,
      request_headers: headers,
      request_query_params: query_params,
      response_types: [
        {200, [{"application/json", {MonobankAPI.Acquiring.Invoices.FiscalChecksResponse, :t}}]},
        {400, [{"application/json", {MonobankAPI.Acquiring.Errors.BadRequest, :t}}]},
        {403, [{"application/json", {MonobankAPI.Acquiring.Errors.Forbidden, :t}}]},
        {404, [{"application/json", {MonobankAPI.Acquiring.Errors.NotFound, :t}}]},
        {405, [{"application/json", {MonobankAPI.Acquiring.Errors.MethodNotAllowed, :t}}]},
        {429, [{"application/json", {MonobankAPI.Acquiring.Errors.TooManyRequests, :t}}]},
        {500, [{"application/json", {MonobankAPI.Acquiring.Errors.InternalServer, :t}}]}
      ]
    }
    |> OpenAPIClient.Client.Operation.put_private(
      __info__: {__MODULE__, :list_fiscal_checks, invoice_id: invoice_id},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end

  @doc """
  Інвалідація рахунку

  Інвалідація рахунку, якщо за ним ще не було здіснено оплати

  ## Arguments

    * `body`

  ## Options

    * `token`: ["X-Token"] Токен з особистого кабінету https://web.monobank.ua/ або тестовий токен з https://api.monobank.ua/. Default value obtained through a call to `Application.get_env(:monobank_api_ex, :token)`
    * `base_url`: Request's base URL. Default value is taken from `@base_url`
    * `client_pipeline`: Client pipeline for making a request. Default value obtained through a call to `OpenAPIClient.Utils.get_config(__operation__, :client_pipeline)}

  """
  @spec remove(MonobankAPI.Acquiring.Invoices.RemoveRequest.t(), [
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
  def remove(body, opts \\ []) do
    client_pipeline = Keyword.get(opts, :client_pipeline)
    base_url = opts[:base_url] || @base_url

    token =
      Keyword.get_lazy(opts, :token, fn -> Application.get_env(:monobank_api_ex, :token) end)

    headers = %{"X-Token" => token}

    %OpenAPIClient.Client.Operation{
      request_base_url: base_url,
      request_url: "/api/merchant/invoice/remove",
      request_body: body,
      request_method: :post,
      request_headers: headers,
      request_types: [{"application/json", {MonobankAPI.Acquiring.Invoices.RemoveRequest, :t}}],
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
      __info__: {__MODULE__, :remove, body: body},
      __opts__: opts,
      __profile__: :acquiring
    )
    |> OpenAPIClient.Client.perform(client_pipeline)
  end
end
