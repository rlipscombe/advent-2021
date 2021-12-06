defmodule Day06ex do
  def main([path, days]) do
    fish =
      File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    fish = evolve(fish, String.to_integer(days))
    IO.puts("Part 1: #{length(fish)}")
  end

  defp evolve(fish, days) do
    evolve_2(fish, length(fish), 0, days)
  end

  defp evolve_2(fish, count, day, days) when day < days do
    IO.puts("Day #{day}: #{count} fish")
    evolve_3(fish, count, [], [], day, days)
  end

  defp evolve_2(fish, _count, _day, _days), do: fish

  defp evolve_3([f | fish], count, acc, fry, day, days) do
    case f do
      0 -> evolve_3(fish, count + 1, [6 | acc], [8 | fry], day, days)
      n -> evolve_3(fish, count, [n - 1 | acc], fry, day, days)
    end
  end

  defp evolve_3([], count, acc, fry, day, days) do
    evolve_2(Enum.reverse(List.flatten([fry, acc])), count, day + 1, days)
  end
end
