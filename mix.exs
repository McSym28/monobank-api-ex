defmodule MonobankAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :monobank_api_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :jason, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:open_api_client_ex, opts_for_open_api_client_ex(Mix.env())},
      {:jason, "~> 1.4", optional: true, only: [:dev, :test]},
      {:httpoison, "~> 2.2", optional: true, only: [:dev, :test]},
      {:mox, "~> 1.1", only: [:dev, :test]},
      {:floki, "~> 0.36", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end

  defp opts_for_open_api_client_ex(env) when env in ~w(dev test)a,
    do: [{:env, :dev} | opts_for_open_api_client_ex(:prod)]

  defp opts_for_open_api_client_ex(_env),
    do: [git: "../../../open-api-client-ex", ref: "cb90fef8dc0a67df623d758121259df08fb3032c"]
end
