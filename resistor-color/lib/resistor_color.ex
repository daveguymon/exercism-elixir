defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """
  @spec code(atom) :: integer()
  @color_codes %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9
  }

  def code(color) do
    @color_codes[color]
  end
end
