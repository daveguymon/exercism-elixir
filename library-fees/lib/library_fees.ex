defmodule LibraryFees do
  def datetime_from_string(string) do
    naive_datetime = NaiveDateTime.from_iso8601(string)
    elem(naive_datetime, 1)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    extra_day_needed? = !before_noon?(checkout_datetime)

    naive_return_date = if extra_day_needed? do
      NaiveDateTime.add(checkout_datetime, 29, :day)
    else
      NaiveDateTime.add(checkout_datetime, 28, :day)
    end

    NaiveDateTime.to_date(naive_return_date)
  end
    

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    
    difference = Date.diff(actual_return_date, planned_return_date)

    if(difference <= 0, do: 0, else: difference)
  end

  def monday?(datetime) do
    date = NaiveDateTime.to_date(datetime)

    day_of_week = Date.day_of_week(date)

    if(day_of_week == 1, do: true, else: false)
  end

  def calculate_late_fee(checkout_datetime, actual_return_datetime, rate) do
    naive_checkout = datetime_from_string(checkout_datetime)
    naive_return = datetime_from_string(actual_return_datetime)
    
    
    date_due = return_date(naive_checkout)

    diff_in_days = days_late(date_due, naive_return)

    apply_discount? = monday?(naive_return)

    late_fee = rate * diff_in_days

    if(apply_discount?, do: trunc(late_fee * 0.5), else: late_fee)
    
  end
end
