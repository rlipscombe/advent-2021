defmodule Day06ex do
  def main([path, days]) do
    fish =
      File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    #Naive.run(fish, days)
    Wise.run(fish, days)
  end
end
