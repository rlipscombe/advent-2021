defmodule Wise do
  def run(fish, days) do
    # We don't actually care about individual fish; we just care about the population.
    # So let's just keep a count of how many fish are of a particular age.
    counts =
      fish
      |> Enum.reduce(
        :array.new(size: 9, fixed: true, default: 0),
        fn age, counts ->
          count = :array.get(age, counts)
          :array.set(age, count + 1, counts)
        end
      )
      |> IO.inspect()

    iterator = fn counts ->
      counts = :array.set(0, :array.get(1, counts), counts)
      counts = :array.set(1, :array.get(2, counts), counts)
      counts = :array.set(2, :array.get(3, counts), counts)
      counts = :array.set(3, :array.get(4, counts), counts)
      counts = :array.set(4, :array.get(5, counts), counts)
      counts = :array.set(5, :array.get(6, counts), counts)
      counts = :array.set(6, :array.get(7, counts) + :array.get(0, counts), counts)
      counts = :array.set(7, :array.get(8, counts), counts)
      :array.set(8, :array.get(0, counts), counts)
    end

    formatter = fn {counts, day} ->
      total = :array.foldl(fn (_i, v, acc) -> acc + v end, 0, counts)
      IO.puts("#{day}: #{total}")
    end

    take = String.to_integer(days) + 1

    counts
    |> Stream.iterate(iterator)
    |> Stream.with_index()
    |> Stream.each(formatter)
    |> Stream.take(take)
    |> Stream.run()
  end
end
