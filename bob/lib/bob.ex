defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do

    cleansed_input = cleanse_input(input)

    cond do
      silence?(cleansed_input) -> "Fine. Be that way!"
      yelled_question?(cleansed_input) -> "Calm down, I know what I'm doing!"
      yelled?(cleansed_input) -> "Whoa, chill out!"
      question?(cleansed_input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp cleanse_input(input) do
    String.trim(input)
  end

  defp has_letters?(input) do
    String.match?(input, ~r/\p{L}/u)
  end

  defp yelled?(input) do
    has_letters?(input) and String.upcase(input) == input
  end

  defp question?(input) do
    String.last(input) == "?"
  end

  defp yelled_question?(input) do
    yelled?(input) and question?(input)
  end

  defp silence?(input) do
    Regex.match?(~r/^\s*$/, input)
  end
end
