defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  
  def recite(strings) do
    do_recite(List.first(strings), strings)
  end

  defp do_recite(first, strings, proverb \\ "")
  defp do_recite(first, strings, proverb) when length(strings) <= 1 do 
    proverb <> "And all for the want of a #{first}.\n"
  end
  
  defp do_recite(first, [hd | rest], proverb) do 
    next_word = List.first(rest)
    updated_proverb = proverb <> "For want of a #{hd} the #{next_word} was lost.\n"

    do_recite(first, rest, updated_proverb)
  end
end
