defmodule MonobankAPIWeb.Router do
  use MonobankAPIWeb, :router

  scope "/__test__", MonobankAPIWeb do
    scope "/acquiring/callbacks", Acquiring.Callbacks do
      scope "/payment_status" do
        post("/", PaymentStatusController, :payment_status)
      end
    end
  end
end
