# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start() do
    Agent.start(fn -> %{registrations: [], counter: 0} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.registrations end)
  end

  def register(pid, register_to) do
    next_id = increment(pid)
    registered_plot = %Plot{plot_id: next_id, registered_to: register_to}
    
    Agent.get_and_update(pid, fn state ->
      {registered_plot, Map.put(state, :registrations, [registered_plot | state.registrations])}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn state -> 
      updated_registrations = Enum.filter(state.registrations, fn registration -> 
        registration.plot_id != plot_id 
      end)

      {:ok, Map.put(state, :registrations, updated_registrations)}
    end)
  end

  def get_registration(pid, plot_id) do
    registration = Agent.get(pid, fn state -> 
      Enum.filter(state.registrations, fn registration -> registration.plot_id == plot_id end) 
      |> List.first()
    end)

    if(registration, do: registration, else: {:not_found, "plot is unregistered"})
  end

  defp increment(pid) do
    Agent.get_and_update(pid, fn state ->
      updated_counter = state.counter + 1 
      {updated_counter, Map.put(state, :counter, updated_counter)} 
    end)
  end
end

