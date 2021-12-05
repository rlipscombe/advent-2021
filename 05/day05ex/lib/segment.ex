defmodule Segment do
  defstruct [:from, :to]

  def new(from, to) when is_struct(from, Point) and is_struct(to, Point),
    do: %__MODULE__{from: from, to: to}
end
