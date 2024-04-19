defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    Enum.uniq(parse_sentence(sentence)) == parse_sentence(sentence)
  end

  defp parse_sentence(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^a-zA-Z]/, "")
    |> String.split("", trim: true)
    |> Enum.sort()
  end
end
