import Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :oapi_generator,
  default: [
    renderer: OpenAPIGenerator.Renderer,
    output: [
      base_module: Default,
      location: "lib"
    ]
  ]

config :open_api_generator_ex,
  default: [
    operations: [
      {:all,
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
    ]
  ]
