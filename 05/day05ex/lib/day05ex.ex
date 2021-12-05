defmodule Day05ex do
  def main([path]) do
    lines = File.read!(path) |> String.trim() |> String.split("\n")

    segments =
      lines
      |> Enum.map(&Regex.run(~r/^(\d+),(\d+) -> (\d+),(\d+)$/, &1, []))
      |> Enum.map(fn [_, x1, y1, x2, y2] ->
        Segment.new(
          Point.new(String.to_integer(x1), String.to_integer(y1)),
          Point.new(String.to_integer(x2), String.to_integer(y2))
        )
      end)

    orthogonals = segments |> Enum.filter(&is_orthogonal_segment/1) |> IO.inspect()

    pairs = for s <- orthogonals, t <- orthogonals, s != t, do: {s, t}
    pairs |> Enum.filter(fn {s, t} -> Geometry.intersect?(s, t) end) |> length() |> IO.inspect()
  end

  defp is_orthogonal_segment(%Segment{from: %Point{x: x}, to: %Point{x: x}}), do: true
  defp is_orthogonal_segment(%Segment{from: %Point{y: y}, to: %Point{y: y}}), do: true
  defp is_orthogonal_segment(%Segment{from: %Point{}, to: %Point{}}), do: false
end
