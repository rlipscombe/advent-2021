defmodule Segment do
  defstruct [:x1, :y1, :x2, :y2]

  def new(x1, y1, x2, y2)
      when is_integer(x1) and is_integer(y1) and is_integer(x2) and is_integer(y2),
      do: %__MODULE__{x1: x1, y1: y1, x2: x2, y2: y2}

  def is_orthogonal?(%__MODULE__{x1: x, x2: x}), do: true
  def is_orthogonal?(%__MODULE__{y1: y, y2: y}), do: true
  def is_orthogonal?(%__MODULE__{}), do: false
end

defimpl Enumerable, for: Segment do
  def reduce(_ = %Segment{}, {:halt, acc}, _fun), do: {:halted, acc}

  def reduce(segment = %Segment{}, {:suspend, acc}, fun),
    do: {:suspended, acc, &reduce(segment, &1, fun)}

  def reduce(%Segment{x1: x1, y1: y1, x2: x2, y2: y2}, {:cont, acc}, fun) do
    direction = fn
      a, b when a < b -> +1
      a, b when a == b -> 0
      a, b when a > b -> -1
    end

    dx = direction.(x1, x2)
    dy = direction.(y1, y2)

    reduce(x1, y1, x2, y2, {:cont, acc}, fun, dx, dy)
  end

  def reduce(x, y, x, y, {:cont, acc}, fun, _, _) do
    {:cont, acc} = fun.({x, y}, acc)
    {:done, acc}
  end

  def reduce(x1, y1, x2, y2, {:cont, acc}, fun, dx, dy) do
    reduce(x1 + dx, y1 + dy, x2, y2, fun.({x1, y1}, acc), fun, dx, dy)
  end

  def count(_), do: {:error, __MODULE__}
  def member?(_, _), do: {:error, __MODULE__}
  def slice(_), do: {:error, __MODULE__}
end
