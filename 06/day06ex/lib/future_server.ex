defmodule Future.Server do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def info(), do: call(:info)

  def call(req), do: GenServer.call(__MODULE__, req, :infinity)
  def cast(req), do: GenServer.cast(__MODULE__, req)

  defmodule State do
    defstruct [:awaiting, :completed, :workers, :pending]
  end

  @impl true
  def init(_) do
    num_workers = System.schedulers_online()
    # num_workers = 2

    workers =
      for _ <- 1..num_workers do
        {:ok, pid} = Future.Worker.start_link(self())
        pid
      end

    state = %State{
      awaiting: Map.new(),
      completed: Map.new(),
      workers: :queue.from_list(workers),
      pending: :queue.new()
    }

    {:ok, state}
  end

  @impl true
  def handle_call(
        :info,
        _from,
        state = %State{
          awaiting: awaiting,
          completed: completed,
          workers: workers,
          pending: pending
        }
      ) do
    info = %{
      awaiting: map_size(awaiting),
      completed: map_size(completed),
      workers: :queue.len(workers),
      pending: :queue.len(pending)
    }

    {:reply, info, state}
  end

  @impl true
  def handle_call({:await, fut}, from, state = %State{awaiting: awaiting, completed: completed}) do
    case Map.fetch(completed, fut) do
      {:ok, result} ->
        {:reply, result, %State{state | completed: Map.delete(completed, fut)}}

      :error ->
        {:noreply, %State{state | awaiting: Map.put(awaiting, fut, from)}}
    end
  end

  @impl true
  def handle_cast({:async, fut, fun}, state = %State{workers: workers, pending: pending}) do
    # Pick a worker, and run the job on that worker.
    # TODO: Alternatively spawn a new worker, up to a concurrency limit,
    # then discard it later?
    case :queue.out(workers) do
      {{:value, worker}, workers} ->
        Future.Worker.cast(worker, {:async, fut, fun})
        {:noreply, %State{state | workers: workers}}

      {:empty, workers} ->
        {:noreply,
         %State{state | workers: workers, pending: :queue.in({:async, fut, fun}, pending)}}
    end
  end

  @impl true
  def handle_cast(
        {:complete, worker, fut, result},
        state = %State{
          awaiting: awaiting,
          completed: completed,
          workers: workers,
          pending: pending
        }
      ) do
    state =
      case :queue.out(pending) do
        {{:value, work}, pending} ->
          Future.Worker.cast(worker, work)
          %State{state | pending: pending}

        {:empty, pending} ->
          %State{state | workers: :queue.in(worker, workers), pending: pending}
      end

    case Map.fetch(awaiting, fut) do
      {:ok, from} ->
        GenServer.reply(from, result)
        {:noreply, %State{state | awaiting: Map.delete(awaiting, fut)}}

      :error ->
        # TODO: This results in a massive number of %Future.Join{} in 'completed'.
        # We should figure out a way to join the dependent futures to the top-level
        # one, so that this doesn't get out of control.
        # Maybe %Future.Join{} should be a MapSet, and we can collapse it as we go, or something.
        {:noreply, %State{state | completed: Map.put(completed, fut, result)}}
    end
  end

  def complete(worker, fut, result) do
    cast({:complete, worker, fut, result})
  end
end
