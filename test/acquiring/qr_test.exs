defmodule MonobankAPI.Acquiring.QRTest do
  use ExUnit.Case, async: true
  import Mox

  @httpoison OpenAPIClient.HTTPoisonMock

  setup :verify_on_exit!

  describe "get_details/2" do
    test "[200] performs a request and encodes MonobankAPI.Acquiring.QR.DetailsResponse from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "amount" => 4200,
                   "ccy" => 980,
                   "invoiceId" => "4EwIUTA12JIZ",
                   "shortQrId" => "OBJE"
                 })

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok,
              %MonobankAPI.Acquiring.QR.DetailsResponse{
                amount: 4200,
                ccy: 980,
                invoice_id: "4EwIUTA12JIZ",
                short_qr_id: "OBJE"
              }} ==
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request and encodes MonobankAPI.Acquiring.Errors.NotFound from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/details",
                                      _,
                                      headers,
                                      options ->
        assert {_, "string"} = List.keyfind(options[:params], "qrId", 0)
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
               MonobankAPI.Acquiring.QR.get_details("string",
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end

  describe "list/1" do
    test "[200] performs a request and encodes MonobankAPI.Acquiring.QR.ListResponse from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
                                      _,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)

        assert {:ok, body_encoded} =
                 Jason.encode(%{
                   "list" => [
                     %{
                       "amountType" => "client",
                       "pageUrl" => "https://pay.mbnk.biz/XJ_DiM4rTd5V",
                       "qrId" => "XJ_DiM4rTd5V",
                       "shortQrId" => "OBJE"
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
              %MonobankAPI.Acquiring.QR.ListResponse{
                list: [
                  %MonobankAPI.Acquiring.QR.ListResponse.Item{
                    amount_type: :client,
                    page_url: "https://pay.mbnk.biz/XJ_DiM4rTd5V",
                    qr_id: "XJ_DiM4rTd5V",
                    short_qr_id: "OBJE"
                  }
                ]
              }} ==
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end

    test "[400] performs a request and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
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
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end

    test "[403] performs a request and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
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
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end

    test "[405] performs a request and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
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
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end

    test "[429] performs a request and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
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
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end

    test "[500] performs a request and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :get,
                                      "https://example.com/api/merchant/qr/list",
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
               MonobankAPI.Acquiring.QR.list(token: "string", base_url: "https://example.com")
    end
  end

  describe "reset_amount/2" do
    test "[200] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes map from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)
        assert {:ok, body_encoded} = Jason.encode(%{"a" => "b"})

        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           headers: [{"Content-Type", "application/json"}],
           body: body_encoded
         }}
      end)

      assert {:ok, %{"a" => "b"}} ==
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[400] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.BadRequest from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[403] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.Forbidden from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[404] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.NotFound from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[405] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.MethodNotAllowed from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[429] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.TooManyRequests from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end

    test "[500] performs a request, encodes MonobankAPI.Acquiring.QR.ResetAmountRequest from request's body and encodes MonobankAPI.Acquiring.Errors.InternalServer from response's body" do
      expect(@httpoison, :request, fn :post,
                                      "https://example.com/api/merchant/qr/reset-amount",
                                      body,
                                      headers,
                                      _ ->
        assert {_, "string"} = List.keyfind(headers, "x-token", 0)
        assert {_, "application/json"} = List.keyfind(headers, "content-type", 0)
        assert {:ok, %{"qrId" => "XJ_DiM4rTd5V"}} == Jason.decode(body)

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
               MonobankAPI.Acquiring.QR.reset_amount(
                 %MonobankAPI.Acquiring.QR.ResetAmountRequest{qr_id: "XJ_DiM4rTd5V"},
                 token: "string",
                 base_url: "https://example.com"
               )
    end
  end
end
