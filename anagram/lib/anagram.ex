defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    sorted_base_chars = format_string(base)
    
    Enum.reject(candidates, fn candidate -> String.downcase(base) == String.downcase(candidate) end)
    |> Enum.filter(fn candidate -> sorted_base_chars == format_string(candidate) end)
  end

  defp format_string(word) do
    String.downcase(word)
    |> String.codepoints()
    |> Enum.sort()
  end
end
