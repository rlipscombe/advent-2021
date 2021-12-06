defmodule Day06ex do
  def main([path, days]) do
    fish =
      File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    iterator = fn fish ->
      {fish, fry} =
        Enum.map_reduce(fish, [], fn
          timer, acc when timer == 0 -> {6, [8 | acc]}
          timer, acc -> {timer - 1, acc}
        end)

      fish ++ fry
    end

    # formatter = &format_fish/1
    formatter = &count_fish/1

    fish
    |> Enum.reverse()
    |> Stream.iterate(iterator)
    |> Stream.with_index()
    |> Stream.each(formatter)
    |> Stream.take(String.to_integer(days) + 1)
    |> Stream.run()
  end

  defp count_fish({fish, day}), do: IO.puts("#{day}: #{length(fish)}")

  defp format_fish({fish, day}),
    do: IO.puts("#{format_prefix(day)} #{Enum.join(Enum.reverse(fish), ",")} (#{length(fish)} fish)")

  defp format_prefix(day) when day == 0, do: "Initial state:"
  defp format_prefix(day) when day == 1, do: "After  #{day} day:"
  defp format_prefix(day) when day > 1 and day < 10, do: "After  #{day} days:"
  defp format_prefix(day), do: "After #{day} days:"
end
