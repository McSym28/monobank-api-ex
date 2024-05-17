defmodule MonobankAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :monobank_api_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :public_key]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:oapi_generator,
       git: "../../../open-api-generator",
       branch: "header_params",
       only: ~w(test dev)a,
       runtime: false,
       override: true},
      {:open_api_generator_ex,
       git: "../../../open-api-generator-ex", only: ~w(test dev)a, runtime: false}
    ]
  end
end
