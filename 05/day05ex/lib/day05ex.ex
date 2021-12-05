defmodule Day05ex do
  def main([path]) do
    lines = File.read!(path) |> String.trim() |> String.split("\n")
    segments = lines |> Enum.map(&parse_segment/1)
    orthogonals = segments |> Enum.filter(&is_orthogonal?/1)

    map =
      Enum.reduce(orthogonals, %{}, fn segment, map ->
        case segment do
          {{x1, y}, {x2, y}} ->
            # horizontal
            Enum.reduce(x1..x2, map, fn x, map ->
              Map.update(map, {x, y}, 1, fn c -> c + 1 end)
            end)

          {{x, y1}, {x, y2}} ->
            # vertical
            Enum.reduce(y1..y2, map, fn y, map ->
              Map.update(map, {x, y}, 1, fn c -> c + 1 end)
            end)
        end
      end)

    part1 =
      Enum.count(map, fn
        {{_x, _y}, c} when c >= 2 -> true
        _ -> false
      end)

    IO.puts("Part1: #{part1}")
  end

  defp parse_segment(str) do
    [_, x1, y1, x2, y2] = Regex.run(~r/^(\d+),(\d+) -> (\d+),(\d+)$/, str)

    {{String.to_integer(x1), String.to_integer(y1)},
     {String.to_integer(x2), String.to_integer(y2)}}
  end

  defp is_orthogonal?({{x, _}, {x, _}}), do: true
  defp is_orthogonal?({{_, y}, {_, y}}), do: true
  defp is_orthogonal?({{_, _}, {_, _}}), do: false
end
