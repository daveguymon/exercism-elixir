defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.split(~r/[^\w'-]|(?<!\w)'|'(?!\w)|_/u, String.downcase(sentence), trim: true)
    |> Enum.frequencies()
  end
end