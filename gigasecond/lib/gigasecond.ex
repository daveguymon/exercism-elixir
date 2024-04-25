defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @gigasecond Integer.pow(10, 9)
  
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
  
    dt = %DateTime{
      year: year, 
      month: month, 
      day: day, 
      hour: hours, 
      minute: minutes, 
      second: seconds, 
      zone_abbr: "UTC", 
      utc_offset: 0, 
      std_offset: 0, 
      time_zone: "Etc/UTC"
    }
    {secs, _} = DateTime.to_gregorian_seconds(dt)
    total_secs = secs + @gigasecond
    calc_dt = DateTime.from_gregorian_seconds(total_secs)

    {{calc_dt.year, calc_dt.month, calc_dt.day}, {calc_dt.hour, calc_dt.minute, calc_dt.second}}
  end
end
