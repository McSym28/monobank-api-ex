import Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :oapi_generator,
  acquiring: [
    processor: OpenAPIClient.Generator.Processor,
    renderer: MonobankAPI.Generator.Renderer,
    naming: [
      rename: [
        {~r/^(.+)Error$/, "Errors.\\1"},
        {~r/^Qr(.+)$/, "QR.\\1"},
        {~r/^QR\.ListItem$/, "QR.ListResponse.Item"},
        {~r/^QR\.ResetRequest$/, "QR.ResetAmountRequest"},
        {~r/^PubkeyResponse$/, "Merchants.PubkeyResponse"},
        {~r/^Invoice([^s].+)$/, "Invoices.\\1"},
        {~r/^FiscalizationItem$/, "Invoices.FiscalizationItem"},
        {~r/^Invoices\.SyncPaymentRequest(.*)$/, "Invoices.CreateSyncPaymentRequest\\1"},
        {~r/^Invoices\.CreateSyncPaymentRequest([^\.].+)$/,
         "Invoices.CreateSyncPaymentRequest.\\1"},
        {~r/^Invoices\.StatusResponse([^\.].+)$/, "Invoices.StatusResponse.\\1"},
        {~r/^Invoices\.CreateRequest([^\.].+)$/, "Invoices.CreateRequest.\\1"},
        {~r/^CancelListItem$/, "Invoices.CancelListItem"},
        {~r/^PaymentDirectRequest(.*)$/, "Invoices.CreateDirectPaymentRequest\\1"},
        {~r/^Invoices\.CreateDirectPaymentRequest([^\.].+)$/,
         "Invoices.CreateDirectPaymentRequest.\\1"},
        {~r/^FiscalCheckListResponse(.*)$/, "Invoices.FiscalChecksResponse\\1"},
        {~r/^(Invoices\.FiscalChecksResponse)Checks$/, "\\1.Check"},
        {~r/^MerchantStatementResponse(.*)$/, "Merchants.StatementsResponse\\1"},
        {~r/^MerchantStatement(Item.*)$/, "Merchants.StatementsResponse.List\\1"},
        {~r/^Merchants\.StatementsResponse\.ListItemCancelList$/,
         "Merchants.StatementsResponse.ListItem.CancelListItem"},
        {~r/^MerchantWalletResponse(.*)$/, "Wallets.GetResponse\\1"},
        {~r/^WalletItem$/, "Wallets.GetResponse.ListItem"},
        {~r/^MerchantWalletPayment(.*)$/, "Wallets.CreatePayment\\1"},
        {~r/^MerchantDetailsResponse$/, "Merchants.DetailsResponse"},
        {~r/^MerchantPaymInfoItem$/, "Merchants.PaymentInfo"},
        {~r/^Merchants\.PaymentInfo([^\.].+)$/, "Merchants.PaymentInfo.\\1"},
        {~r/^Merchants\.PaymentInfo\.BasketOrderDiscounts$/,
         "Merchants.PaymentInfo.BasketOrder.Discount"},
        {~r/^SubmerchantListResponse$/, "Merchants.Submerchants.ListResponse"},
        {~r/^Merchants\.Submerchants\.ListResponseList$/,
         "Merchants.Submerchants.ListResponse.Item"},
        {~r/^Invoices\.SyncPaymentRequest\.MerchantPaymInfo$/,
         "Invoices.SyncPaymentRequest.MerchantPaymentInfo"},
        {~r/^EmployeeListResponse$/, "Merchants.Employees.ListResponse"},
        {~r/^Merchants\.Employees\.ListResponseList$/, "Merchants.Employees.ListResponse.Item"}
      ]
    ],
    output: [
      base_module: MonobankAPI.Acquiring,
      location: "lib/acquiring"
    ]
  ]

config :open_api_client_ex,
  "$base": [
    example_generator: MonobankAPI.Generator.ExampleGenerator
  ],
  acquiring: [
    base_url: "https://api.monobank.ua",
    operations: [
      {:*,
       [
         params: [
           {{"X-Token", :header},
            [name: "token", default: {Application, :get_env, [:monobank_api_ex, :token]}]},
           {{"X-Cms", :header},
            [name: "cms", default: {Application, :get_env, [:monobank_api_ex, :cms]}]},
           {{"X-Cms-Version", :header},
            [
              name: "cms_version",
              default: {Application, :get_env, [:monobank_api_ex, :cms_version]}
            ]}
         ]
       ]}
    ],
    test_location: "test/acquiring"
  ]
