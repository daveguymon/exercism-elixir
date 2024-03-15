defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    if has_letters(word), do: update_points(word), else: 0
  end

  defp has_letters(word) do
    String.trim(word) != ""
  end

  defp update_points(word) do
    points_key = %{
      1 => ["A","E","I","O","U","L","N","R","S","T"],
      2 => ["D","G"],
      3 => ["B","C","M","P"],
      4 => ["F","H","V","W","Y"],
      5 => ["K"],
      8 => ["J","X"],
      10 => ["Q","Z"]
    }

    split_word = String.split(word, "", trim: true)
    points_list = for character <- split_word, 
                  {points, letters} <- points_key, 
                  letter <- letters, 
                  String.upcase(character) == letter, 
                  into: [], 
                  do: points
    List.foldl(points_list, 0, &+/2)
  end
end


