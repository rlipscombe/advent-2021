defmodule Day07ex do
  def main([path]) do
    crabs =
      File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    distance = fn crab, pos ->
      abs(crab - pos)
    end

    {pos, cost} = herd_crabs(crabs, distance)
    IO.puts("Part 1: Moving to #{pos} would cost #{cost} fuel")

    part2 = fn crab, pos ->
      n = distance.(crab, pos)
      div(n * (n + 1), 2)
    end

    {pos, cost} = herd_crabs(crabs, part2)
    IO.puts("Part 2: Moving to #{pos} would cost #{cost} fuel")
  end

  defp herd_crabs(crabs, calc) do
    {min, max} = Enum.min_max(crabs)

    costs =
      Enum.map(min..max, fn pos ->
        cost =
          Enum.reduce(crabs, 0, fn crab, acc ->
            acc + calc.(crab, pos)
          end)

        {pos, cost}
      end)

    {pos, cost} = Enum.min_by(costs, fn {_, cost} -> cost end)
    {pos, cost}
  end
end
