defmodule Geometry do
  # See https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
  def intersect?(seg1 = %Segment{from: p1, to: q1}, seg2 = %Segment{from: p2, to: q2}) do
    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, p2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)

    cond do
      o1 != o2 and o3 != o4 -> true
      o1 == :clockwise and on_segment?(p1, p2, q1) -> true
      o2 == :clockwise and on_segment?(p1, q2, q1) -> true
      o3 == :clockwise and on_segment?(p2, p1, q2) -> true
      o4 == :clockwise and on_segment?(p2, q1, q2) -> true
      true -> false
    end
  end

  defp orientation(p = %Point{}, q = %Point{}, r = %Point{}) do
    case (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y) do
      0 -> :collinear
      val when val > 0 -> :clockwise
      _ -> :counterclockwise
    end
  end

  defp on_segment?(p = %Point{}, q = %Point{}, r = %Point{}) do
    q.x <= max(p.x, r.x) and
      q.x >= min(p.x, r.x) and
      q.y <= max(p.y, r.y) and
      q.y >= min(p.y, r.y)
  end
end
