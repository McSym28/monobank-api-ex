defmodule MonobankAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :monobank_api_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp elixirc_paths(:dev),
    do: ["lib_dev", "deps/open_api_client_ex/lib_dev" | elixirc_paths(:prod)]

  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:jason, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:open_api_client_ex,
       git: "../../../open-api-client-ex", ref: "5eeb3c00f7f8f779cede16fb10fca9c784d14ea0"},
      {:jason, "~> 1.4", optional: true, only: [:dev, :test]},
      {:httpoison, "~> 2.2", optional: true, only: [:dev, :test]},
      {:oapi_generator,
       git: "../../../open-api-generator", branch: "behaviour_impl", only: [:dev, :test]},
      {:mox, "~> 1.1", only: [:dev, :test]},
      {:floki, "~> 0.36", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end
end
