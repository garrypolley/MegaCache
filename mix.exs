defmodule MegaCache.MixProject do
  use Mix.Project

  def project do
    [
      app: :mega_cache,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools, :wx],
      mod: {MegaCache.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # Add broadway and phoenix as deps so they are on the machine
      # {:broadway, ">= 1.1.0"},
      # {:phoenix, ">= 1.7.14"},
      # {:mnesia_rocksdb, git: "https://github.com/aeternity/mnesia_rocksdb.git", tag: "2.0.1"},
      # {:poison, "~> 6.0"},
      # {:httpoison, "~> 2.2"},
      {:poolboy, "~> 1.5"},
      {:plug_cowboy, "~> 2.6"}
    ]
  end
end
