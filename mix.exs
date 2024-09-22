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

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  defp elixirc_paths(:test), do: ["test/support" | elixirc_paths(:dev)]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application, do: application(Mix.env())

  defp application(:test), do: [{:mod, {MonobankAPI.Application, []}} | application(:dev)]
  defp application(_env), do: [extra_applications: [:logger, :runtime_tools]]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:open_api_client_ex, opts_for_open_api_client_ex(Mix.env())},
      {:jason, "~> 1.4", optional: true, only: [:dev, :test]},
      {:httpoison, "~> 2.2", optional: true, only: [:dev, :test]},
      {:mox, "~> 1.2", only: [:dev, :test]},
      {:floki, "~> 0.36", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:phoenix, "~> 1.7", only: :test},
      {:bandit, "~> 1.5", only: :test}
    ]
  end

  defp opts_for_open_api_client_ex(env) when env in ~w(dev test)a,
    do: [{:env, :dev} | opts_for_open_api_client_ex(:prod)]

  defp opts_for_open_api_client_ex(_env),
    do: [git: "../../../open-api-client-ex", ref: "fd7822fc265964d4004435ef96174c02f1bac5e2"]
end
