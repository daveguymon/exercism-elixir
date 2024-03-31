defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&do_translation/1)
    |> Enum.join(" ")
  end

  defp do_translation(phrase) do
    cond do
      has_vowel_sound_pattern?(phrase) ->
        phrase <> "ay"
      true ->
        translate_consonant_cluster(phrase)
    end
  end

  defp has_vowel_sound_pattern?(phrase) do
    vowel_pattern = ~r/^eq|^[aeiou]|^[xy][^aeiou]/i
    String.match?(phrase, vowel_pattern)
  end

  defp translate_consonant_cluster(phrase) do
    [beginning_consonants] = Regex.run(~r/^y|^[^aeiou]qu|^qu|^[^aeiouy]+/i, phrase)
    {consonants, remainder} = String.split_at(phrase, String.length(beginning_consonants))

    remainder <> consonants <> "ay"
  end
end
