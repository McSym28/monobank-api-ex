ExUnit.start()
Mox.defmock(OpenAPIClient.HTTPoisonMock, for: HTTPoison.Base)
Mox.defmock(OpenAPIClientMock, for: OpenAPIClient)
Mox.defmock(MonobankAPI.Acquiring.CallbacksMock, for: MonobankAPI.Acquiring.Callbacks)
