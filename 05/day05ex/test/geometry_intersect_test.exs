defmodule Geometry.Test do
  use ExUnit.Case

  describe "intersection tests" do
    test "#1" do
      p1 = Point.new(1, 1)
      q1 = Point.new(10, 1)
      p2 = Point.new(1, 2)
      q2 = Point.new(10, 2)

      refute Geometry.intersect?(Segment.new(p1, q1), Segment.new(p2, q2))
    end

    test "#2" do
      p1 = Point.new(10, 0)
      q1 = Point.new(0, 10)
      p2 = Point.new(0, 0)
      q2 = Point.new(10, 10)

      assert Geometry.intersect?(Segment.new(p1, q1), Segment.new(p2, q2))
    end

    test "#3" do
      p1 = Point.new(-5, -5)
      q1 = Point.new(0, 0)
      p2 = Point.new(1, 1)
      q2 = Point.new(10, 10)

      refute Geometry.intersect?(Segment.new(p1, q1), Segment.new(p2, q2))
    end
  end
end
