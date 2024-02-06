defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    battery = remote_car.battery_percentage
    
    cond do
      battery > 0 ->
        "Battery at #{battery}%"
      true ->
        "Battery empty"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    initial_battery = remote_car.battery_percentage
    initial_distance = remote_car.distance_driven_in_meters

    case initial_battery == 0 do
      true ->
        remote_car
      false ->
        remote_car
        |> Map.put(:battery_percentage, initial_battery - 1)
        |> Map.put(:distance_driven_in_meters, initial_distance + 20)
    end
  end
end
