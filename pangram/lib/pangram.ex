defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    alphabet = ?a..?z 
    |> Enum.map(&to_string([&1]))
    
    cleaned_characters = sentence
    |> String.replace(~r/[^a-zA-Z]/, "")
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.uniq()
    |> Enum.sort()

    alphabet == cleaned_characters
  end
end
