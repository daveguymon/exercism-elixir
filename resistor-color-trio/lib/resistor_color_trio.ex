defmodule ResistorColorTrio do
  @color_map %{
    black: 0, brown: 1, red: 2, orange: 3, yellow: 4,
    green: 5, blue: 6, violet: 7, grey: 8, white: 9
  }
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([c1, c2, c3 | _extra]) do
    [val1, val2, val3] = [@color_map[c1], @color_map[c2], @color_map[c3]]    

    ohms = (val1 * 10 + val2) * Integer.pow(10, val3)
    format_label(ohms)
  end

  defp format_label(ohms) do
    cond do
      ohms < 1_000 -> {ohms, :ohms}
      ohms < 1_000_000 -> {div(ohms,1_000), :kiloohms}
      ohms < 1_000_000_000 -> {div(ohms,1_000_000), :megaohms}
      true -> {div(ohms,1_000_000_000), :gigaohms}
    end
  end
end
