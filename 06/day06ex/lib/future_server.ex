defmodule Future.Server do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def call(req), do: GenServer.call(__MODULE__, req, :infinity)
  def cast(req), do: GenServer.cast(__MODULE__, req)

  defmodule State do
    defstruct [:awaiting, :completed]
  end

  @impl true
  def init(_) do
    state = %State{
      awaiting: Map.new(),
      completed: Map.new()
    }

    {:ok, state}
  end

  @impl true
  def handle_call({:await, fut}, from, state = %State{awaiting: awaiting, completed: completed}) do
    #IO.puts("await #{inspect(fut)}")

    case Map.fetch(completed, fut) do
      {:ok, result} ->
        #IO.puts("...completed, returning #{inspect(result)}")
        {:reply, result, %State{state | completed: Map.delete(completed, fut)}}

      :error ->
        #IO.puts("not complete, awaiting")
        {:noreply, %State{state | awaiting: Map.put(awaiting, fut, from)}}
    end
  end

  @impl true
  def handle_cast({:async, fut, fun}, state = %State{awaiting: awaiting, completed: completed}) do
    result = fun.()
    #IO.inspect("async result: #{inspect(result)}")

    case Map.fetch(awaiting, fut) do
      {:ok, from} ->
        #IO.puts("from is already awaiting #{inspect(fut)}")
        GenServer.reply(from, result)
        {:noreply, %State{state | awaiting: Map.delete(awaiting, fut)}}

      :error ->
        #IO.puts("#{inspect(fut)} completed, no waiters")
        {:noreply, %State{state | completed: Map.put(completed, fut, result)}}
    end
  end
end
