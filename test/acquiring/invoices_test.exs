defmodule MonobankAPI.Acquiring.InvoicesTest do
  use ExUnit.Case, async: true
  import Mox

  @httpoison OpenAPIClient.HTTPoisonMock
  @client OpenAPIClient.ClientMock

  setup :verify_on_exit!

  describe "cancel/2" do
    test "[200] performs a request, encodes CancelRequest from request's body and encodes CancelResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "createdDate" => "2024-01-02T01:23:45Z",
                   "modifiedDate" => "2024-01-02T01:23:45Z",
                   "status" => "failure"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.CancelResponse{
                created_date: ~U[2024-01-02 01:23:45Z],
                modified_date: ~U[2024-01-02 01:23:45Z],
                status: :failure
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes CancelRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes CancelRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes CancelRequest from request's body and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes CancelRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes CancelRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes CancelRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/cancel",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 5000,
                  "extRef" => "635ace02599849e981b2cd7a65f417fe",
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.cancel(
                 %MonobankAPI.Acquiring.Invoices.CancelRequest{
                   amount: 5000,
                   ext_ref: "635ace02599849e981b2cd7a65f417fe",
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "create/2" do
    test "[200] performs a request, encodes CreateRequest from request's body and encodes CreateResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "invoiceId" => "p2_9ZgpZVsl3",
                   "pageUrl" => "https://pay.mbnk.biz/p2_9ZgpZVsl3"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.CreateResponse{
                invoice_id: "p2_9ZgpZVsl3",
                page_url: "https://pay.mbnk.biz/p2_9ZgpZVsl3"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes CreateRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes CreateRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes CreateRequest from request's body and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes CreateRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes CreateRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes CreateRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/create",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "agentFeePercent" => 1.42,
                  "amount" => 4200,
                  "ccy" => 980,
                  "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "qrId" => "XJ_DiM4rTd5V",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "tipsEmployeeId" => "string",
                  "validity" => 3600,
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.create(
                 %MonobankAPI.Acquiring.Invoices.CreateRequest{
                   agent_fee_percent: 1.42,
                   amount: 4200,
                   ccy: 980,
                   code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   qr_id: "XJ_DiM4rTd5V",
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data: %MonobankAPI.Acquiring.Invoices.CreateRequest.SaveCardData{
                     save_card: true,
                     wallet_id: "69f780d841a0434aa535b08821f4822c"
                   },
                   tips_employee_id: "string",
                   validity: 3600,
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "finalize/2" do
    test "[200] performs a request, encodes FinalizeRequest from request's body and encodes FinalizeResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} = Jason.encode(%{"status" => "success"})

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok, %MonobankAPI.Acquiring.Invoices.FinalizeResponse{status: :success}} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes FinalizeRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes FinalizeRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes FinalizeRequest from request's body and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes FinalizeRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes FinalizeRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes FinalizeRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/finalize",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "invoiceId" => "p2_9ZgpZVsl3",
                  "items" => [
                    %{
                      "barcode" => "3b2a558cc6e44e218cdce301d80a1779",
                      "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                      "footer" => "Футер",
                      "header" => "Хідер",
                      "name" => "Табуретка",
                      "qty" => 2,
                      "sum" => 2100,
                      "tax" => [1],
                      "uktzed" => "uktzedcode"
                    }
                  ]
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.finalize(
                 %MonobankAPI.Acquiring.Invoices.FinalizeRequest{
                   amount: 4200,
                   invoice_id: "p2_9ZgpZVsl3",
                   items: [
                     %MonobankAPI.Acquiring.Invoices.FiscalizationItem{
                       barcode: "3b2a558cc6e44e218cdce301d80a1779",
                       code: "d21da1c47f3c45fca10a10c32518bdeb",
                       footer: "Футер",
                       header: "Хідер",
                       name: "Табуретка",
                       qty: 2,
                       sum: 2100,
                       tax: [1],
                       uktzed: "uktzedcode"
                     }
                   ]
                 },
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "list_fiscal_checks/2" do
    test "[200] performs a request and encodes FiscalChecksResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "checks" => [
                     %{
                       "file" =>
                         "CJFVBERi0xLj4QKJaqrrK0KMSAw123I4G9ia3go38PAovQ43JlYXRvciAoQXBhY2hl5IEZPUCBWZXJzaW9uIfDIuMykKL...",
                       "fiscalizationSource" => "monopay",
                       "id" => "a2fd4aef-cdb8-4e25-9b36-b6d4672c554d",
                       "status" => "done",
                       "statusDescription" => "",
                       "taxUrl" => "https://cabinet.tax.gov.ua/cashregs/check",
                       "type" => "sale"
                     }
                   ]
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.FiscalChecksResponse{
                checks: [
                  %MonobankAPI.Acquiring.Invoices.FiscalChecksResponse.Check{
                    file:
                      "CJFVBERi0xLj4QKJaqrrK0KMSAw123I4G9ia3go38PAovQ43JlYXRvciAoQXBhY2hl5IEZPUCBWZXJzaW9uIfDIuMykKL...",
                    fiscalization_source: :monopay,
                    id: "a2fd4aef-cdb8-4e25-9b36-b6d4672c554d",
                    status: :done,
                    status_description: "",
                    tax_url: "https://cabinet.tax.gov.ua/cashregs/check",
                    type: :sale
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/fiscal-checks",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.list_fiscal_checks("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "create_direct_payment/2" do
    test "[200] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Wallets.CreatePaymentResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "amount" => 4200,
                   "ccy" => 980,
                   "createdDate" => "2024-01-02T01:23:45Z",
                   "failureReason" => "Неправильний CVV код",
                   "invoiceId" => "2210012MPLYwJjVUzchj",
                   "modifiedDate" => "2024-01-02T01:23:45Z",
                   "status" => "success",
                   "tdsUrl" => "https://example.com/tds/url"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Wallets.CreatePaymentResponse{
                amount: 4200,
                ccy: 980,
                created_date: ~U[2024-01-02 01:23:45Z],
                failure_reason: "Неправильний CVV код",
                invoice_id: "2210012MPLYwJjVUzchj",
                modified_date: ~U[2024-01-02 01:23:45Z],
                status: :success,
                tds_url: "https://example.com/tds/url"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes CreateDirectPaymentRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/payment-direct",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "cardData" => %{"cvv" => "123", "exp" => "0642", "pan" => "4242424242424242"},
                  "ccy" => 980,
                  "initiationKind" => "client",
                  "merchantPaymInfo" => %{
                    "basketOrder" => [
                      %{
                        "barcode" => "string",
                        "code" => "d21da1c47f3c45fca10a10c32518bdeb",
                        "discounts" => [
                          %{"mode" => "PERCENT", "type" => "DISCOUNT", "value" => 1.0}
                        ],
                        "footer" => "string",
                        "header" => "string",
                        "icon" => "string",
                        "name" => "Табуретка",
                        "qty" => 2,
                        "sum" => 2100,
                        "tax" => [],
                        "uktzed" => "string",
                        "unit" => "шт."
                      }
                    ],
                    "comment" => "Покупка щастя",
                    "customerEmails" => [],
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  },
                  "paymentType" => "debit",
                  "redirectUrl" => "https://example.com/your/website/result/page",
                  "saveCardData" => %{
                    "saveCard" => true,
                    "walletId" => "69f780d841a0434aa535b08821f4822c"
                  },
                  "webHookUrl" =>
                    "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_direct_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest{
                   amount: 4200,
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.CardData{
                     cvv: "123",
                     exp: "0642",
                     pan: "4242424242424242"
                   },
                   ccy: 980,
                   initiation_kind: :client,
                   merchant_paym_info: %MonobankAPI.Acquiring.Merchants.PaymentInfo{
                     basket_order: [
                       %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder{
                         barcode: "string",
                         code: "d21da1c47f3c45fca10a10c32518bdeb",
                         discounts: [
                           %MonobankAPI.Acquiring.Merchants.PaymentInfo.BasketOrder.Discount{
                             mode: :percent,
                             type: :discount,
                             value: 1.0
                           }
                         ],
                         footer: "string",
                         header: "string",
                         icon: "string",
                         name: "Табуретка",
                         qty: 2,
                         sum: 2100,
                         tax: [],
                         uktzed: "string",
                         unit: "шт."
                       }
                     ],
                     comment: "Покупка щастя",
                     customer_emails: [],
                     destination: "Покупка щастя",
                     reference: "84d0070ee4e44667b31371d8f8813947"
                   },
                   payment_type: :debit,
                   redirect_url: "https://example.com/your/website/result/page",
                   save_card_data:
                     %MonobankAPI.Acquiring.Invoices.CreateDirectPaymentRequest.SaveCardData{
                       save_card: true,
                       wallet_id: "69f780d841a0434aa535b08821f4822c"
                     },
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "get_payment_info/2" do
    test "[200] performs a request and encodes PaymentInfoResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "amount" => 4200,
                   "approvalCode" => "662476",
                   "cancelList" => [
                     %{
                       "amount" => 4200,
                       "approvalCode" => "662476",
                       "ccy" => 980,
                       "createdDate" => "2024-01-02T01:23:45Z",
                       "extRef" => "635ace02599849e981b2cd7a65f417fe",
                       "modifiedDate" => "2024-01-02T01:23:45Z",
                       "rrn" => "060189181768",
                       "status" => "failure"
                     }
                   ],
                   "ccy" => 980,
                   "country" => "804",
                   "createdDate" => "2024-01-02T01:23:45Z",
                   "domesticCard" => true,
                   "fee" => 420,
                   "finalAmount" => 4200,
                   "maskedPan" => "444403******1902",
                   "paymentMethod" => "apple",
                   "paymentScheme" => "bnpl_later_30",
                   "rrn" => "060189181768",
                   "terminal" => "MI001088"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.PaymentInfoResponse{
                amount: 4200,
                approval_code: "662476",
                cancel_list: [
                  %MonobankAPI.Acquiring.Invoices.CancelListItem{
                    amount: 4200,
                    approval_code: "662476",
                    ccy: 980,
                    created_date: ~U[2024-01-02 01:23:45Z],
                    ext_ref: "635ace02599849e981b2cd7a65f417fe",
                    modified_date: ~U[2024-01-02 01:23:45Z],
                    rrn: "060189181768",
                    status: :failure
                  }
                ],
                ccy: 980,
                country: "804",
                created_date: ~U[2024-01-02 01:23:45Z],
                domestic_card: true,
                fee: 420,
                final_amount: 4200,
                masked_pan: "444403******1902",
                payment_method: :apple,
                payment_scheme: :bnpl_later_30,
                rrn: "060189181768",
                terminal: "MI001088"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/payment-info",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_payment_info("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "remove/2" do
    test "[200] performs a request, encodes RemoveRequest from request's body and encodes map from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)
        assert {:ok, body_encoded} = Jason.encode(%{"a" => "b"})

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok, %{"a" => "b"}} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes RemoveRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes RemoveRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes RemoveRequest from request's body and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes RemoveRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes RemoveRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes RemoveRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/remove",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok, %{"invoiceId" => "p2_9ZgpZVsl3"}} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.remove(
                 %MonobankAPI.Acquiring.Invoices.RemoveRequest{invoice_id: "p2_9ZgpZVsl3"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "get_status/2" do
    test "[200] performs a request and encodes StatusResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "amount" => 4200,
                   "cancelList" => [
                     %{
                       "amount" => 4200,
                       "approvalCode" => "662476",
                       "ccy" => 980,
                       "createdDate" => "2024-01-02T01:23:45Z",
                       "extRef" => "635ace02599849e981b2cd7a65f417fe",
                       "modifiedDate" => "2024-01-02T01:23:45Z",
                       "rrn" => "060189181768",
                       "status" => "failure"
                     }
                   ],
                   "ccy" => 980,
                   "createdDate" => "2024-01-02T01:23:45Z",
                   "destination" => "Покупка щастя",
                   "errCode" => "59",
                   "failureReason" => "Неправильний CVV код",
                   "finalAmount" => 4200,
                   "invoiceId" => "p2_9ZgpZVsl3",
                   "modifiedDate" => "2024-01-02T01:23:45Z",
                   "paymentInfo" => %{
                     "agentFee" => 1,
                     "approvalCode" => "662476",
                     "bank" => "Універсал Банк",
                     "country" => "804",
                     "fee" => 1,
                     "maskedPan" => "444403******1902",
                     "paymentMethod" => "apple",
                     "paymentSystem" => "visa",
                     "rrn" => "060189181768",
                     "terminal" => "MI001088",
                     "tranId" => "13194036"
                   },
                   "reference" => "84d0070ee4e44667b31371d8f8813947",
                   "status" => "created",
                   "tipsInfo" => %{"amount" => 4200, "employeeId" => "string"},
                   "walletData" => %{
                     "cardToken" => "67XZtXdR4NpKU3",
                     "status" => "created",
                     "walletId" => "c1376a611e17b059aeaf96b73258da9c"
                   }
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.StatusResponse{
                amount: 4200,
                cancel_list: [
                  %MonobankAPI.Acquiring.Invoices.CancelListItem{
                    amount: 4200,
                    approval_code: "662476",
                    ccy: 980,
                    created_date: ~U[2024-01-02 01:23:45Z],
                    ext_ref: "635ace02599849e981b2cd7a65f417fe",
                    modified_date: ~U[2024-01-02 01:23:45Z],
                    rrn: "060189181768",
                    status: :failure
                  }
                ],
                ccy: 980,
                created_date: ~U[2024-01-02 01:23:45Z],
                destination: "Покупка щастя",
                err_code: "59",
                failure_reason: "Неправильний CVV код",
                final_amount: 4200,
                invoice_id: "p2_9ZgpZVsl3",
                modified_date: ~U[2024-01-02 01:23:45Z],
                payment_info: %MonobankAPI.Acquiring.Invoices.StatusResponse.PaymentInfo{
                  agent_fee: 1,
                  approval_code: "662476",
                  bank: "Універсал Банк",
                  country: "804",
                  fee: 1,
                  masked_pan: "444403******1902",
                  payment_method: :apple,
                  payment_system: :visa,
                  rrn: "060189181768",
                  terminal: "MI001088",
                  tran_id: "13194036"
                },
                reference: "84d0070ee4e44667b31371d8f8813947",
                status: :created,
                tips_info: %MonobankAPI.Acquiring.Invoices.StatusResponse.TipsInfo{
                  amount: 4200,
                  employee_id: "string"
                },
                wallet_data: %MonobankAPI.Acquiring.Invoices.StatusResponse.WalletData{
                  card_token: "67XZtXdR4NpKU3",
                  status: :created,
                  wallet_id: "c1376a611e17b059aeaf96b73258da9c"
                }
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/invoice/status",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "invoiceId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.get_status("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "create_sync_payment/2" do
    test "[200] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes StatusResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "amount" => 4200,
                   "cancelList" => [
                     %{
                       "amount" => 4200,
                       "approvalCode" => "662476",
                       "ccy" => 980,
                       "createdDate" => "2024-01-02T01:23:45Z",
                       "extRef" => "635ace02599849e981b2cd7a65f417fe",
                       "modifiedDate" => "2024-01-02T01:23:45Z",
                       "rrn" => "060189181768",
                       "status" => "failure"
                     }
                   ],
                   "ccy" => 980,
                   "createdDate" => "2024-01-02T01:23:45Z",
                   "destination" => "Покупка щастя",
                   "errCode" => "59",
                   "failureReason" => "Неправильний CVV код",
                   "finalAmount" => 4200,
                   "invoiceId" => "p2_9ZgpZVsl3",
                   "modifiedDate" => "2024-01-02T01:23:45Z",
                   "paymentInfo" => %{
                     "agentFee" => 1,
                     "approvalCode" => "662476",
                     "bank" => "Універсал Банк",
                     "country" => "804",
                     "fee" => 1,
                     "maskedPan" => "444403******1902",
                     "paymentMethod" => "apple",
                     "paymentSystem" => "visa",
                     "rrn" => "060189181768",
                     "terminal" => "MI001088",
                     "tranId" => "13194036"
                   },
                   "reference" => "84d0070ee4e44667b31371d8f8813947",
                   "status" => "created",
                   "tipsInfo" => %{"amount" => 4200, "employeeId" => "string"},
                   "walletData" => %{
                     "cardToken" => "67XZtXdR4NpKU3",
                     "status" => "created",
                     "walletId" => "c1376a611e17b059aeaf96b73258da9c"
                   }
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Invoices.StatusResponse{
                amount: 4200,
                cancel_list: [
                  %MonobankAPI.Acquiring.Invoices.CancelListItem{
                    amount: 4200,
                    approval_code: "662476",
                    ccy: 980,
                    created_date: ~U[2024-01-02 01:23:45Z],
                    ext_ref: "635ace02599849e981b2cd7a65f417fe",
                    modified_date: ~U[2024-01-02 01:23:45Z],
                    rrn: "060189181768",
                    status: :failure
                  }
                ],
                ccy: 980,
                created_date: ~U[2024-01-02 01:23:45Z],
                destination: "Покупка щастя",
                err_code: "59",
                failure_reason: "Неправильний CVV код",
                final_amount: 4200,
                invoice_id: "p2_9ZgpZVsl3",
                modified_date: ~U[2024-01-02 01:23:45Z],
                payment_info: %MonobankAPI.Acquiring.Invoices.StatusResponse.PaymentInfo{
                  agent_fee: 1,
                  approval_code: "662476",
                  bank: "Універсал Банк",
                  country: "804",
                  fee: 1,
                  masked_pan: "444403******1902",
                  payment_method: :apple,
                  payment_system: :visa,
                  rrn: "060189181768",
                  terminal: "MI001088",
                  tran_id: "13194036"
                },
                reference: "84d0070ee4e44667b31371d8f8813947",
                status: :created,
                tips_info: %MonobankAPI.Acquiring.Invoices.StatusResponse.TipsInfo{
                  amount: 4200,
                  employee_id: "string"
                },
                wallet_data: %MonobankAPI.Acquiring.Invoices.StatusResponse.WalletData{
                  card_token: "67XZtXdR4NpKU3",
                  status: :created,
                  wallet_id: "c1376a611e17b059aeaf96b73258da9c"
                }
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "BAD_REQUEST", "errText" => "empty 'invoiceId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 400,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.BadRequest{
                err_code: "BAD_REQUEST",
                err_text: "empty 'invoiceId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "FORBIDDEN", "errText" => "forbidden"})

        {:ok,
         %HTTPoison.Response{
           status_code: 403,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.Forbidden{
                err_code: "FORBIDDEN",
                err_text: "forbidden"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.NotFound from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "NOT_FOUND", "errText" => "invalid 'qrId'"})

        {:ok,
         %HTTPoison.Response{
           status_code: 404,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.NotFound{
                err_code: "NOT_FOUND",
                err_text: "invalid 'qrId'"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "METHOD_NOT_ALLOWED",
                   "errText" => "Method not allowed"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 405,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.MethodNotAllowed{
                err_code: "METHOD_NOT_ALLOWED",
                err_text: "Method not allowed"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{"errCode" => "TMR", "errText" => "too many requests"})

        {:ok,
         %HTTPoison.Response{
           status_code: 429,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.TooManyRequests{
                err_code: "TMR",
                err_text: "too many requests"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes CreateSyncPaymentRequest from request's body and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/invoice/sync-payment",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-cms", 0)
        assert {_, "string"} = List.keyfind(headers, "x-cms-version", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, "application/json"} ==
                 (with {_, content_type_request} <- List.keyfind(headers, "content-type", 0),
                       {:ok, {media_type, media_subtype, _parameters}} =
                         OpenAPIClient.Client.Operation.parse_content_type_header(
                           content_type_request
                         ) do
                    {:ok, "#{media_type}/#{media_subtype}"}
                  end)

        assert {:ok,
                %{
                  "amount" => 4200,
                  "applePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "cardData" => %{
                    "cavv" => "123",
                    "cvv" => "123",
                    "dsTranId" => "12",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "mit" => "1",
                    "pan" => "4242424242424242",
                    "sst" => 2.0,
                    "tReqID" => "51",
                    "tavv" => "tavv",
                    "tid" => "12",
                    "type" => "DPAN"
                  },
                  "ccy" => 980,
                  "googlePay" => %{
                    "cryptogram" => "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                    "eciIndicator" => "02",
                    "exp" => "0642",
                    "token" => "4242424242424242"
                  },
                  "merchantPaymInfo" => %{
                    "destination" => "Покупка щастя",
                    "reference" => "84d0070ee4e44667b31371d8f8813947"
                  }
                }} == Jason.decode(body)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "errCode" => "INTERNAL_ERROR",
                   "errText" => "internal server error"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 500,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:error,
              %MonobankAPI.Acquiring.Errors.InternalServer{
                err_code: "INTERNAL_ERROR",
                err_text: "internal server error"
              }} ==
               MonobankAPI.Acquiring.Invoices.create_sync_payment(
                 %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest{
                   amount: 4200,
                   apple_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.ApplePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   card_data: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.CardData{
                     cavv: "123",
                     cvv: "123",
                     ds_tran_id: "12",
                     eci_indicator: "02",
                     exp: "0642",
                     mit: "1",
                     pan: "4242424242424242",
                     sst: 2.0,
                     t_req_id: "51",
                     tavv: "tavv",
                     tid: "12",
                     type: :dpan
                   },
                   ccy: 980,
                   google_pay: %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.GooglePay{
                     cryptogram: "AQAAAAoAR9qDi9kAAAAAgGpLpoA=",
                     eci_indicator: "02",
                     exp: "0642",
                     token: "4242424242424242"
                   },
                   merchant_paym_info:
                     %MonobankAPI.Acquiring.Invoices.CreateSyncPaymentRequest.MerchantPaymInfo{
                       destination: "Покупка щастя",
                       reference: "84d0070ee4e44667b31371d8f8813947"
                     }
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end
  end
end
