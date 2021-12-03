defmodule Day03ex do
  def main([path]) do
    inputs =
      File.read!(path)
      |> String.trim()
      |> String.split()

    counts = get_counts(inputs)

    # Yes, epsilon is the bit-inverse of gamma, but Bitwise.bnot thinks it's
    # signed, and weirdness happens. So we'll do it the long way.
    {gamma, epsilon} =
      Enum.reduce(Tuple.to_list(counts), {0, 0}, fn
        c, {g, e} when c > 0 -> {Bitwise.bsl(g, 1) + 1, Bitwise.bsl(e, 1)}
        c, {g, e} when c < 0 -> {Bitwise.bsl(g, 1), Bitwise.bsl(e, 1) + 1}
      end)

    IO.puts("Part 1: gamma = #{gamma}, epsilon = #{epsilon}, result = #{gamma * epsilon}")

    oxygen = get_oxygen(inputs)
    co2 = get_co2(inputs)

    IO.puts("Part 2: oxygen = #{oxygen}, co2 = #{co2}, result = #{oxygen * co2}")
  end

  defp get_counts(inputs) do
    word_size = byte_size(hd(inputs))

    counts =
      List.duplicate(0, word_size)
      |> List.to_tuple()

    counts =
      Enum.reduce(inputs, counts, fn input, acc when is_tuple(counts) ->
        Enum.reduce(Enum.with_index(String.to_charlist(input)), acc, fn {v, i}, a ->
          case v do
            ?0 -> decrement_elem(a, i)
            ?1 -> increment_elem(a, i)
          end
        end)
      end)

    counts
  end

  defp increment_elem(tuple, index),
    do: Kernel.put_elem(tuple, index, Kernel.elem(tuple, index) + 1)

  defp decrement_elem(tuple, index),
    do: Kernel.put_elem(tuple, index, Kernel.elem(tuple, index) - 1)

  defp get_oxygen(inputs), do: get_gas(inputs, &oxygen_probe/2, 0)
  defp get_co2(inputs), do: get_gas(inputs, &co2_probe/2, 0)

  defp oxygen_probe(counts, index) do
    case Kernel.elem(counts, index) do
      x when x >= 0 -> "1"
      _ -> "0"
    end
  end

  defp co2_probe(counts, index) do
    case Kernel.elem(counts, index) do
      x when x < 0 -> "1"
      _ -> "0"
    end
  end

  defp get_gas([result], _probe, _index), do: String.to_integer(result, 2)

  defp get_gas(inputs, probe, index) do
    counts = get_counts(inputs)

    needle = probe.(counts, index)

    next =
      Enum.filter(inputs, fn input ->
        case String.at(input, index) do
          ^needle -> true
          _ -> false
        end
      end)

    get_gas(next, probe, index + 1)
  end
end
