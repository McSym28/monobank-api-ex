defmodule MonobankAPIWeb.Acquiring.Callbacks.PaymentStatusControllerTest do
  use MonobankAPIWeb.ConnCase

  import Mox

  @behaviour_module MonobankAPI.Acquiring.CallbacksMock
  @client OpenAPIClientMock

  setup :verify_on_exit!

  describe "payment_status/2" do
    test "[200] processes a request and decodes Invoices.Status.Response from request's body", %{
      conn: conn
    } do
      expect(@client, :callback, &OpenAPIClient.callback/1)

      expect(@behaviour_module, :payment_status, fn x_sign, body, _opts ->
        assert "string" == x_sign

        assert %MonobankAPI.Acquiring.Invoices.Status.Response{
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
                 payment_info: %MonobankAPI.Acquiring.Invoices.Status.Response.PaymentInfo{
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
                 tips_info: %MonobankAPI.Acquiring.Invoices.Status.Response.TipsInfo{
                   amount: 4200,
                   employee_id: "string"
                 },
                 wallet_data: %MonobankAPI.Acquiring.Invoices.Status.Response.WalletData{
                   card_token: "67XZtXdR4NpKU3",
                   status: :created,
                   wallet_id: "c1376a611e17b059aeaf96b73258da9c"
                 }
               } == body

        :ok
      end)

      conn =
        conn
        |> Plug.Conn.put_req_header("x-sign", "string")
        |> Plug.Conn.put_req_header("content-type", "application/json")
        |> post(
          "/__test__/acquiring/callbacks/payment_status",
          %{
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
          }
          |> Jason.encode!()
        )

      assert response(conn, 200)
    end
  end
end
