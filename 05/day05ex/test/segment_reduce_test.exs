defmodule Segment.Reduce.Test do
  use ExUnit.Case

  defp reduce(segment) do
    Enum.reduce(segment, [], fn {x, y}, acc -> [{x, y} | acc] end) |> Enum.reverse()
  end

  test "single point" do
    assert reduce(Segment.new(4, 4, 4, 4)) == [{4, 4}]
  end

  test "vertical, y decreasing (north)" do
    assert reduce(Segment.new(1, 3, 1, 0)) == [{1, 3}, {1, 2}, {1, 1}, {1, 0}]
  end

  test "horizontal, x increasing (east)" do
    assert reduce(Segment.new(0, 1, 3, 1)) == [{0, 1}, {1, 1}, {2, 1}, {3, 1}]
  end

  test "vertical, y increasing (south)" do
    assert reduce(Segment.new(1, 0, 1, 3)) == [{1, 0}, {1, 1}, {1, 2}, {1, 3}]
  end

  test "horizontal, x decreasing (west)" do
    assert reduce(Segment.new(3, 1, 0, 1)) == [{3, 1}, {2, 1}, {1, 1}, {0, 1}]
  end

  test "x increasing, y decreasing (north east)" do
    {x, y, d} = {4, 3, 3}
    assert reduce(Segment.new(x, y, x + d, y - d)) == [{4, 3}, {5, 2}, {6, 1}, {7, 0}]
  end

  test "x increasing, y increasing (south east)" do
    {x, y, d} = {4, 3, 3}
    assert reduce(Segment.new(x, y, x + d, y + d)) == [{4, 3}, {5, 4}, {6, 5}, {7, 6}]
  end

  test "x decreasing, y increasing (south west)" do
    {x, y, d} = {4, 3, 3}
    assert reduce(Segment.new(x, y, x - d, y + d)) == [{4, 3}, {3, 4}, {2, 5}, {1, 6}]
  end

  test "x decreasing, y decreasing (north west)" do
    {x, y, d} = {4, 3, 3}
    assert reduce(Segment.new(x, y, x - d, y - d)) == [{4, 3}, {3, 2}, {2, 1}, {1, 0}]
  end
end
