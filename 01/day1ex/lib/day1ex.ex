defmodule Day1ex do
  def main([path]) do
    lines =
      File.read!(path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

    result =
      lines
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(0, fn [a, b], acc ->
        if b > a, do: acc + 1, else: acc
      end)

    IO.puts("#{result}")
  end
end
