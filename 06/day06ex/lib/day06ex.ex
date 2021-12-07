defmodule Day06ex do
  def main([path, days]) do
    fish =
      File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    days = String.to_integer(days)

    {:ok, _} = Future.start_link()

    Future.async(fn -> evolve(fish, 0, days) end)
    |> Future.await()
    |> List.flatten()
    |> Enum.count()
    |> IO.inspect()
  end

  def evolve([], _day, _days), do: %Future.Result{value: []}
  def evolve(fish, day, days) when day >= days, do: %Future.Result{value: fish}

  def evolve(fish, day, days) do
    {fish, fry} =
      Enum.map_reduce(fish, [], fn
        0, acc -> {6, [8 | acc]}
        x, acc -> {x - 1, acc}
      end)

    Future.join([
      Future.async(fn -> evolve(fish, day + 1, days) end),
      Future.async(fn -> evolve(fry, day + 1, days) end)
    ])
  end
end
