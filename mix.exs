defmodule DungeonCrawl.MixProject do
  use Mix.Project

  def project do
    [
      app: :dungeon_crawl,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
    ]
  end
  
end

# In the deps function we must return a list of tuples. The first item is the name of
# the library, the second item is the version, and the third is an optional list of
# keyword options. We’re saying here that we have the dialyxir library, the version
# must be >= 0.5.0 and < 1.0.0 , and we only need it in the dev environment


# dialyzer: [plt_add_apps: [:mix]]
# This is to avoid dialyzer complain about Mix missing functions, because with that Mix # is included in the analysis
