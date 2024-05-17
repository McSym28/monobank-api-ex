defmodule MonobankAPI.WebhookTest do
  use ExUnit.Case, async: true
  alias MonobankAPI.Webhook

  describe "verify/3" do
    setup do
      public_key_file = "test/fixtures/webhook_public_key.pem"
      public_key_binary = File.read!(public_key_file)

      x_sign_base64 =
        "MEUCIQC/mVKhi8FKoayul2Mim3E2oaIOCNJk5dEXxTqbkeJSOQIgOM0hsW0qcP2H8iXy1aQYpmY0SJWEaWur7nQXlKDCFxA="

      body = """
      {
        "invoiceId": "p2_9ZgpZVsl3",
        "status": "created",
        "failureReason": "string",
        "amount": 4200,
        "ccy": 980,
        "finalAmount": 4200,
        "createdDate": "2019-08-24T14:15:22Z",
        "modifiedDate": "2019-08-24T14:15:22Z",
        "reference": "84d0070ee4e44667b31371d8f8813947",
        "cancelList": [
          {
            "status": "processing",
            "amount": 4200,
            "ccy": 980,
            "createdDate": "2019-08-24T14:15:22Z",
            "modifiedDate": "2019-08-24T14:15:22Z",
            "approvalCode": "662476",
            "rrn": "060189181768",
            "extRef": "635ace02599849e981b2cd7a65f417fe"
          }
        ]
      }\
      """

      %{
        public_key_file: public_key_file,
        public_key_binary: public_key_binary,
        x_sign_base64: x_sign_base64,
        body: body
      }
    end

    test "successful when public key is read from file", %{
      public_key_file: public_key_file,
      x_sign_base64: x_sign_base64,
      body: body
    } do
      assert :ok == Webhook.verify(body, x_sign_base64, public_key: {:file, public_key_file})
    end

    test "successful when public key is passed as a Base64-encoded string", %{
      public_key_binary: public_key_binary,
      x_sign_base64: x_sign_base64,
      body: body
    } do
      public_key_base64 = Base.encode64(public_key_binary)
      assert :ok == Webhook.verify(body, x_sign_base64, public_key: {:base64, public_key_base64})
    end

    test "successful when public key is passed as binary", %{
      public_key_binary: public_key_binary,
      x_sign_base64: x_sign_base64,
      body: body
    } do
      assert :ok == Webhook.verify(body, x_sign_base64, public_key: public_key_binary)
    end

    test "successful when the default value for public key is used", %{
      x_sign_base64: x_sign_base64,
      body: body
    } do
      assert :ok == Webhook.verify(body, x_sign_base64)
    end

    test "fails when an incorrecly Base64-encoded string is passed for X-Sign", %{
      public_key_binary: public_key_binary,
      body: body
    } do
      assert {:error, :x_sign_base64_decode} == Webhook.verify(body, "abc", public_key_binary)
    end

    test "fails when an incorrecly Base64-encoded string is passed for public key", %{
      x_sign_base64: x_sign_base64,
      body: body
    } do
      assert {:error, :public_key_base64_decode} ==
               Webhook.verify(body, x_sign_base64, public_key: {:base64, "abc"})
    end

    test "fails when a non existent file is passed for public key", %{
      x_sign_base64: x_sign_base64,
      body: body
    } do
      assert {:error, {:public_key_read_file, :enoent}} ==
               Webhook.verify(body, x_sign_base64, public_key: {:file, "test/non-existent.pem"})
    end

    test "fails signature verification", %{
      public_key_binary: public_key_binary,
      x_sign_base64: x_sign_base64
    } do
      assert {:error, :verify_failed} ==
               Webhook.verify("abc", x_sign_base64, public_key: public_key_binary)
    end
  end
end
