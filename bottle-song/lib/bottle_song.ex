defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  @numbers %{
    0 => "No",
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten"
  }

  def recite(start_bottle, take_down) do
    generate_verse(start_bottle, take_down, "")
  end

  defp generate_verse(_start_bottle, 0, song), do: song
  defp generate_verse(count, verses, song) do
    term = Map.get(@numbers, count)
    next_term = Map.get(@numbers, count - 1)
    noun = noun_type(term)
    next_noun = noun_type(next_term)
    verse = """
            #{term} green #{noun} hanging on the wall,
            #{term} green #{noun} hanging on the wall,
            And if one green bottle should accidentally fall,
            There'll be #{String.downcase(next_term)} green #{next_noun} hanging on the wall.
            """
    verse = if(verses == 1, do: String.trim_trailing(verse, "\n"), else: verse <> "\n")
    generate_verse(count - 1, verses - 1, song <> verse)
  end

  defp noun_type(term) do
    if(term == "One", do: "bottle", else: "bottles")
  end
end
