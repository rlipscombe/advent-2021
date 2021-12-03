defmodule Day03ex do
  def main([path]) do
    inputs =
      File.read!(path)
      |> String.trim()
      |> String.split()

    word_size = byte_size(hd(inputs))

    counts =
      List.duplicate(0, word_size)
      |> List.to_tuple()

    counts =
      Enum.reduce(inputs, counts, fn input, acc when is_tuple(counts) ->
        Enum.reduce(Enum.with_index(String.to_charlist(input)), acc, fn {v, i}, a ->
          curr = Kernel.elem(a, i)

          case v do
            ?0 -> Kernel.put_elem(a, i, curr - 1)
            ?1 -> Kernel.put_elem(a, i, curr + 1)
          end
        end)
      end)

    # Yes, epsilon is the bit-inverse of gamma, but Bitwise.bnot thinks it's
    # signed, and weirdness happens. So we'll do it the long way.
    {gamma, epsilon} =
      Enum.reduce(Tuple.to_list(counts), {0, 0}, fn
        c, {g, e} when c > 0 -> {Bitwise.bsl(g, 1) + 1, Bitwise.bsl(e, 1)}
        c, {g, e} when c < 0 -> {Bitwise.bsl(g, 1), Bitwise.bsl(e, 1) + 1}
      end)

    IO.puts("Part 1: gamma = #{gamma}, epsilon = #{epsilon}, result = #{gamma * epsilon}")
  end
end
