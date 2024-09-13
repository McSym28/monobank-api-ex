import Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :oapi_generator,
  acquiring: [
    processor: OpenAPIClient.Generator.Processor,
    renderer: MonobankAPI.Generator.Renderer,
    naming: [
      rename: [
        {"ReceiptResponse", "InvoiceReceiptResponse"},
        {~r/RecipientCardAdd(Request|Response)/, "Wallets.AddRecipientCard\\1"},
        {~r/^(.+)Error$/, "Errors.\\1"},
        {~r/^Qr(.+)$/, "QR.\\1"},
        {~r/^QR\.ListItem$/, "QR.List.Response.Item"},
        {~r/^QR\.ResetRequest$/, "QR.ResetAmountRequest"},
        {~r/^PubkeyResponse$/, "Merchants.PubkeyResponse"},
        {~r/^Invoice([^s].+)$/, "Invoices.\\1"},
        {~r/^FiscalizationItem$/, "Invoices.FiscalizationItem"},
        {~r/^Invoices\.SyncPaymentRequest(.*)$/, "Invoices.CreateSyncPaymentRequest\\1"},
        {~r/^Invoices\.(CreateSyncPaymentRequest|StatusResponse|CreateRequest|CreateDirectPaymentRequest)([^\.].+)$/,
         "Invoices.\\1.\\2"},
        {~r/^CancelListItem$/, "Invoices.CancelListItem"},
        {~r/^PaymentDirectRequest(.*)$/, "Invoices.CreateDirectPaymentRequest\\1"},
        {~r/^FiscalCheckListResponse(.*)$/, "Invoices.ListFiscalChecksResponse\\1"},
        {~r/^(Invoices\.ListFiscalChecksResponse)Checks$/, "\\1.Check"},
        {~r/^MerchantStatementResponse(.*)$/, "Merchants.ListStatements.Response\\1"},
        {~r/^MerchantStatement(Item.*)$/, "Merchants.ListStatements.Response.List\\1"},
        {~r/^Merchants\.ListStatements\.Response\.ListItemCancelList$/,
         "Merchants.ListStatements.Response.ListItem.CancelListItem"},
        {~r/^MerchantWalletResponse(.*)$/, "Wallets.Get.Response\\1"},
        {~r/^WalletItem$/, "Wallets.Get.Response.ListItem"},
        {~r/^MerchantWalletPayment(.*)$/, "Wallets.CreatePayment\\1"},
        {~r/^MerchantDetailsResponse$/, "Merchants.DetailsResponse"},
        {~r/^MerchantPaymInfoItem$/, "Merchants.PaymentInfo"},
        {~r/^Merchants\.PaymentInfo([^\.].+)$/, "Merchants.PaymentInfo.\\1"},
        {~r/^Merchants\.PaymentInfo\.BasketOrderDiscounts$/,
         "Merchants.PaymentInfo.BasketOrder.Discount"},
        {~r/^SubmerchantListResponse$/, "Merchants.ListSubmerchants.Response"},
        {~r/^Merchants\.ListSubmerchants\.ResponseList$/,
         "Merchants.ListSubmerchants.Response.Item"},
        {~r/^Invoices\.SyncPaymentRequest\.MerchantPaymInfo$/,
         "Invoices.SyncPaymentRequest.MerchantPaymentInfo"},
        {~r/^EmployeeListResponse$/, "Merchants.ListEmployees.Response"},
        {~r/^Merchants\.ListEmployees\.ResponseList$/, "Merchants.ListEmployees.Response.Item"},
        {~r/^(.+[^\.])((?<!Bad)Request|Response)$/, "\\1.\\2"},
        {~r/^(.+\.(?:Request|Response))([^\.].+)$/, "\\1.\\2"}
      ]
    ],
    output: [
      base_module: MonobankAPI.Acquiring,
      location: "lib/monobank_api/acquiring"
    ]
  ]

config :open_api_client_ex,
  "$base": [
    test_renderer: MonobankAPI.Generator.TestRenderer
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
    test_location: "test/monobank_api/acquiring"
  ]
