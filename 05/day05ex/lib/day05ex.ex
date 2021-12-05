defmodule Day05ex do
  def main([path]) do
    lines = File.read!(path) |> String.trim() |> String.split("\n")
    segments = lines |> Enum.map(&parse_segment/1)

    chart_segments = fn segment, map ->
      Enum.reduce(segment, map, fn {x, y}, map ->
        Map.update(map, {x, y}, 1, fn c -> c + 1 end)
      end)
    end

    is_dangerous? = fn
      {{_x, _y}, c} when c >= 2 -> true
      _ -> false
    end

    orthogonals = segments |> Enum.filter(&Segment.is_orthogonal?/1)
    part1 = Enum.reduce(orthogonals, %{}, chart_segments) |> Enum.count(is_dangerous?)
    IO.puts("Part1: #{part1}")

    part2 = Enum.reduce(segments, %{}, chart_segments) |> Enum.count(is_dangerous?)
    IO.puts("Part2: #{part2}")
  end

  defp parse_segment(str) do
    [_, x1, y1, x2, y2] = Regex.run(~r/^(\d+),(\d+) -> (\d+),(\d+)$/, str)

    Segment.new(
      String.to_integer(x1),
      String.to_integer(y1),
      String.to_integer(x2),
      String.to_integer(y2)
    )
  end
end
