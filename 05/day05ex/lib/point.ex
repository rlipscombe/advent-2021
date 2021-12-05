defmodule Point do
  defstruct [:x, :y]

  def new(x, y) when is_integer(x) and is_integer(y), do: %__MODULE__{x: x, y: y}
end
