defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601(string)
    |> elem(1)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_allowed = if !before_noon?(checkout_datetime), do: 29, else: 28

    NaiveDateTime.add(checkout_datetime, days_allowed, :day)
    |> NaiveDateTime.to_date()
  end
    
  def days_late(planned_return_date, actual_return_datetime) do
    difference = NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)

    if difference <= 0, do: 0, else: difference
  end

  def monday?(datetime) do
    day_of_week = 
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week()

    if day_of_week == 1, do: true, else: false
  end

  def calculate_late_fee(checkout_datetime, actual_return_datetime, rate) do
    naive_checkout = datetime_from_string(checkout_datetime)
    naive_return = datetime_from_string(actual_return_datetime)
    
    days_late = return_date(naive_checkout)
    |> days_late(naive_return)

    late_fee = days_late * rate

    if monday?(naive_return), do: trunc(late_fee * 0.5), else: late_fee
  end
end
