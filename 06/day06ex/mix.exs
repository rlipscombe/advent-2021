defmodule Day06ex.MixProject do
  use Mix.Project

  def project do
    [
      app: :day06ex,
      version: "0.1.0",
      deps: deps(),
      default_task: "escript.build",
      escript: escript_options()
    ]
  end

  defp escript_options do
    [
      main_module: Day06ex,
      path: "day06ex"
    ]
  end

  defp deps do
    []
  end
end
