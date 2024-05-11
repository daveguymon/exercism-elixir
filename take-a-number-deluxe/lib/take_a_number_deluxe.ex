defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(init_args) do
    min = Keyword.get(init_args, :min_number)
    max = Keyword.get(init_args, :max_number)
    timeout = Keyword.get(init_args, :auto_shutdown_timeout, :infinity)
    
    case TakeANumberDeluxe.State.new(min, max, timeout) do
      {:ok, state} ->
        {:ok, state, timeout}
      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    timeout = Map.get(state, :auto_shutdown_timeout, :infinity)
    {:reply, state, state, timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    timeout = Map.get(state, :auto_shutdown_timeout)
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, next_number, updated_state} -> {:reply, {:ok, next_number}, updated_state, timeout}
      {:error, message} -> {:reply, {:error, message}, state, timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    timeout = Map.get(state, :auto_shutdown_timeout)
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, updated_state} -> {:reply, {:ok, next_number}, updated_state, timeout}
      {:error, message} -> {:reply, {:error, message}, state, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    min = Map.get(state, :min_number)
    max = Map.get(state, :max_number)
    timeout = Map.get(state, :auto_shutdown_timeout)
    
    {:ok, reset_state} = TakeANumberDeluxe.State.new(min, max, timeout)
    {:noreply, reset_state, timeout}
  end

  @impl GenServer
  def handle_info(msg, state) do
    timeout = Map.get(state, :auto_shutdown_timeout)
    case msg do
      :timeout ->
        {:stop, :normal, state}
      _ ->
        {:noreply, state, timeout}
    end
  end
end
