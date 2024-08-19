defmodule MonobankAPI.Acquiring.MerchantsTest do
  use ExUnit.Case, async: true
  import Mox

  @httpoison OpenAPIClient.HTTPoisonMock
  @client OpenAPIClient.ClientMock

  setup :verify_on_exit!

  describe "get_details/1" do
    test "[200] performs a request and encodes DetailsResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "edrpou" => "4242424242",
                   "merchantId" => "12o4Vv7EWy",
                   "merchantName" => "Your Favourite Company"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Merchants.DetailsResponse{
                edrpou: "4242424242",
                merchant_id: "12o4Vv7EWy",
                merchant_name: "Your Favourite Company"
              }} ==
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/details",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_details(
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "list_employees/1" do
    test "[200] performs a request and encodes Employees.ListResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "list" => [
                     %{
                       "extRef" => "abra_kadabra",
                       "id" => "3QFX7e7mZfo3R",
                       "name" => "Артур Дент"
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
              %MonobankAPI.Acquiring.Merchants.Employees.ListResponse{
                list: [
                  %MonobankAPI.Acquiring.Merchants.Employees.ListResponse.Item{
                    ext_ref: "abra_kadabra",
                    id: "3QFX7e7mZfo3R",
                    name: "Артур Дент"
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/employee/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_employees(
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "get_pubkey/1" do
    test "[200] performs a request and encodes PubkeyResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "key" =>
                     "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFK0UxRnBVZzczYmhGdmp2SzlrMlhJeTZtQkU1MQpib2F0RU1qU053Z1l5ZW55blpZQWh3Z3dyTGhNY0FpT25SYzNXWGNyMGRrY2NvVnFXcVBhWVQ5T3hRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg=="
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.Merchants.PubkeyResponse{
                key:
                  "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFK0UxRnBVZzczYmhGdmp2SzlrMlhJeTZtQkU1MQpib2F0RU1qU053Z1l5ZW55blpZQWh3Z3dyTGhNY0FpT25SYzNXWGNyMGRrY2NvVnFXcVBhWVQ5T3hRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg=="
              }} ==
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/pubkey",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.get_pubkey(
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "list_statements/2" do
    test "[200] performs a request and encodes StatementsResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "list" => [
                     %{
                       "amount" => 4200,
                       "approvalCode" => "662476",
                       "cancelList" => [
                         %{
                           "amount" => 4200,
                           "approvalCode" => "662476",
                           "ccy" => 980,
                           "date" => "2024-01-02T01:23:45Z",
                           "maskedPan" => "444403******1902",
                           "rrn" => "060189181768"
                         }
                       ],
                       "ccy" => 980,
                       "date" => "2024-01-02T01:23:45Z",
                       "destination" => "Покупка щастя",
                       "invoiceId" => "2205175v4MfatvmUL2oR",
                       "maskedPan" => "444403******1902",
                       "paymentScheme" => "bnpl_later_30",
                       "profitAmount" => 4100,
                       "reference" => "84d0070ee4e44667b31371d8f8813947",
                       "rrn" => "060189181768",
                       "shortQrId" => "OBJE",
                       "status" => "success"
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
              %MonobankAPI.Acquiring.Merchants.StatementsResponse{
                list: [
                  %MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem{
                    amount: 4200,
                    approval_code: "662476",
                    cancel_list: [
                      %MonobankAPI.Acquiring.Merchants.StatementsResponse.ListItem.CancelListItem{
                        amount: 4200,
                        approval_code: "662476",
                        ccy: 980,
                        date: ~U[2024-01-02 01:23:45Z],
                        masked_pan: "444403******1902",
                        rrn: "060189181768"
                      }
                    ],
                    ccy: 980,
                    date: ~U[2024-01-02 01:23:45Z],
                    destination: "Покупка щастя",
                    invoice_id: "2205175v4MfatvmUL2oR",
                    masked_pan: "444403******1902",
                    payment_scheme: :bnpl_later_30,
                    profit_amount: 4100,
                    reference: "84d0070ee4e44667b31371d8f8813947",
                    rrn: "060189181768",
                    short_qr_id: "OBJE",
                    status: :success
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
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
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
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
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
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
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
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
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/statement",
                                      _,
                                      headers,
                                      options ->
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "from", 0)
        assert {_, 1_706_750_625} = List.keyfind(options[:params], "to", 0)
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
               MonobankAPI.Acquiring.Merchants.list_statements(~U[2024-02-01 01:23:45Z],
                 token: "string",
                 to: ~U[2024-02-01 01:23:45Z],
                 base_url: "https://example.com"
               )
    end
  end

  describe "list_submerchants/1" do
    test "[200] performs a request and encodes Submerchants.ListResponse from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "list" => [
                     %{
                       "code" => "0a8637b3bccb42aa93fdeb791b8b58e9",
                       "edrpou" => "4242424242",
                       "iban" => "UA213996220000026007233566001"
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
              %MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse{
                list: [
                  %MonobankAPI.Acquiring.Merchants.Submerchants.ListResponse.Item{
                    code: "0a8637b3bccb42aa93fdeb791b8b58e9",
                    edrpou: "4242424242",
                    iban: "UA213996220000026007233566001"
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes Errors.BadRequest from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes Errors.Forbidden from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes Errors.MethodNotAllowed from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes Errors.TooManyRequests from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes Errors.InternalServer from response's body" do
      expect(@client, :perform, &OpenAPIClient.Client.perform/2)

      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/submerchant/list",
                                      _,
                                      headers,
                                      _ ->
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
               MonobankAPI.Acquiring.Merchants.list_submerchants(
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end
end
