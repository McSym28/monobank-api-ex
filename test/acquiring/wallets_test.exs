defmodule MonobankAPI.Acquiring.WalletsTest do
  use ExUnit.Case, async: true
  import Mox

  @httpoison OpenAPIClient.HTTPoisonMock

  setup :verify_on_exit!

  describe "get/2" do
    test "[200] performs a request and encodes MonobankAPI.Acquiring.Wallets.GetResponse from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "wallet" => [
                     %{
                       "cardToken" => "67XZtXdR4NpKU3",
                       "country" => "804",
                       "maskedPan" => "424242******4242"
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
              %MonobankAPI.Acquiring.Wallets.GetResponse{
                wallet: [
                  %MonobankAPI.Acquiring.Wallets.GetResponse.ListItem{
                    card_token: "67XZtXdR4NpKU3",
                    country: "804",
                    masked_pan: "424242******4242"
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
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
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
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
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
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
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
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
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/wallet",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "walletId", 0)
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
               MonobankAPI.Acquiring.Wallets.get("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "delete_card/2" do
    test "[200] performs a request and encodes map from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {:ok, body_encoded} = Jason.encode(%{"a" => "b"})

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok, %{"a" => "b"}} ==
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
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
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
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
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
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
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
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
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :delete,
                                      "https://example.com/api/merchant/wallet/card",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "cardToken", 0)
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
               MonobankAPI.Acquiring.Wallets.delete_card("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "create_payment/2" do
    test "[200] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Wallets.CreatePaymentResponse from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
                   web_hook_url:
                     "https://example.com/mono/acquiring/webhook/maybesomegibberishuniquestringbutnotnecessarily"
                 },
                 token: "string",
                 cms_version: "string",
                 cms: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes MonobankAPI.Acquiring.Wallets.CreatePaymentRequest from request's body and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/wallet/payment",
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
                  "cardToken" => "67XZtXdR4NpKU3",
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
                  "redirectUrl" => "https://example.com/your/website/result/page",
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
               MonobankAPI.Acquiring.Wallets.create_payment(
                 %MonobankAPI.Acquiring.Wallets.CreatePaymentRequest{
                   amount: 4200,
                   card_token: "67XZtXdR4NpKU3",
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
                   redirect_url: "https://example.com/your/website/result/page",
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
end
