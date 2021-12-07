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

  defp evolve(fish, days) when is_list(fish) do
    evolve_2(fish, length(fish), 0, days)
  end

  defp evolve_2(fish, count, day, days) when is_list(fish) and day < days do
    IO.puts("Day #{day}: #{count} fish")
    evolve_3(fish, count, [], [], day, days)
  end

  defp evolve_2(fish, _count, _day, _days), do: fish

  defp evolve_3([list | lists], count, acc, fry, day, days) when is_list(list) do
    evolve_4(list, lists, count, acc, fry, day, days)
  end

  defp evolve_3(list, count, acc, fry, day, days) when is_list(list) do
    evolve_4(list, [], count, acc, fry, day, days)
  end

  defp evolve_4([f | fish], lists, count, acc, fry, day, days) when is_integer(f) do
    case f do
      0 -> evolve_4(fish, lists, count + 1, [6 | acc], [8 | fry], day, days)
      n -> evolve_4(fish, lists, count, [n - 1 | acc], fry, day, days)
    end
  end

  defp evolve_4([], [list | lists], count, acc, fry, day, days) do
    evolve_4(list, lists, count, acc, fry, day, days)
  end

  defp evolve_4([], [], count, acc, fry, day, days) do
    evolve_2([fry, acc], count, day + 1, days)
  end
end
