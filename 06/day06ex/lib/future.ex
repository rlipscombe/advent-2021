defmodule Future do
  def start_link(), do: Future.Server.start_link()

  defstruct [:ref]

  defmodule Join do
    defstruct [:futures]
  end

  defmodule Result do
    defstruct [:value]
  end

  def async(fun) do
    fut = %__MODULE__{ref: make_ref()}
    Future.Server.cast({:async, fut, fun})
    fut
  end

  def await(fut = %Future{}) do
    result =
      case Future.Server.call({:await, fut}) do
        %Future.Result{value: value} ->
          value

        next = %Future.Join{} ->
          await(next)
      end

    result
  end

  def await(_fut = %Future.Join{futures: futures}), do: await_many(futures, [])

  defp await_many([], acc), do: acc

  defp await_many([fut | futures], acc) do
    await_many(futures, [await(fut) | acc])
  end

  def join(futures), do: %Future.Join{futures: futures}
end
