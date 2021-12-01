defmodule Day1ex do
  def main([path]) do
    lines =
      File.read!(path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

    part1 =
      lines
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(0, fn [a, b], acc ->
        if b > a, do: acc + 1, else: acc
      end)

    IO.puts("Part 1 = #{part1}")

    chunks = lines |> Enum.chunk_every(3, 1, :discard)

    sums =
      chunks
      |> Enum.reduce([], fn [a, b, c], acc ->
        [a + b + c | acc]
      end)
      |> Enum.reverse()

    part2 =
      sums
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(0, fn [a, b], acc ->
        if b > a, do: acc + 1, else: acc
      end)

    IO.puts("Part 2 = #{part2}")
  end
end
