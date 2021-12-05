defmodule Day05ex.MixProject do
  use Mix.Project

  def project do
    [
      app: :day05ex,
      version: "0.1.0",
      deps: deps(),
      default_task: "escript.build",
      escript: escript_options()
    ]
  end
  
  defp escript_options do
    [
      main_module: Day05ex,
      path: "day05ex"
    ]
  end
  
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
