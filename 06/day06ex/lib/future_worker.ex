defmodule Future.Worker do
  use GenServer

  def start_link(parent) do
    GenServer.start_link(__MODULE__, [parent])
  end

  def cast(worker, req), do: GenServer.cast(worker, req)

  @impl true
  def init([parent]) do
    {:ok, parent}
  end

  @impl true
  def handle_cast({:async, fut, fun}, state) do
    result = fun.()

    # Note that this serializes through a singleton server; maybe we should
    # pick from a pool of reply processes, and put the chosen one in the future?
    Future.Server.complete(self(), fut, result)
    {:noreply, state}
  end
end
