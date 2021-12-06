defmodule Wise do
  def run(fish, days) when is_list(fish) and is_integer(days) do
    # We don't actually care about individual fish; we just care about the population.
    # So let's just keep a count of how many fish are of a particular age.
    counts =
      fish
      |> Enum.reduce(
        %{},
        fn age, counts -> Map.update(counts, age, 1, fn x -> x + 1 end) end
      )
      |> IO.inspect()

    counts = evolve(counts, days)
    total = Map.to_list(counts) |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)
    IO.puts(total)
  end

  #   iterator = fn counts ->
  #   end

  #   formatter = fn {counts, day} ->
  #     total = Map.to_list(counts) |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)
  #     IO.puts("#{day}: #{total}")
  #   end

  #   take = String.to_integer(days) + 1

  #   counts
  #   |> Stream.iterate(iterator)
  #   |> Stream.with_index()
  #   |> Stream.each(formatter)
  #   |> Stream.take(take)
  #   |> Stream.run()
  # end

  defp evolve(counts, days) when days > 0 do
    next = %{
      0 => Map.get(counts, 1, 0),
      1 => Map.get(counts, 2, 0),
      2 => Map.get(counts, 3, 0),
      3 => Map.get(counts, 4, 0),
      4 => Map.get(counts, 5, 0),
      5 => Map.get(counts, 6, 0),
      6 => Map.get(counts, 7, 0) + Map.get(counts, 0, 0),
      7 => Map.get(counts, 8, 0),
      8 => Map.get(counts, 0, 0)
    }

    evolve(next, days - 1)
  end

  defp evolve(counts, 0) do
    counts
  end
end
