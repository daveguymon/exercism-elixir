defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    parsed_isbn = 
    isbn
    |> parse_string()
    
    if valid?(parsed_isbn) do
      parsed_isbn
      |> calculate_valid_isbn()
    else
      false
    end
  end

  defp calculate_valid_isbn(isbn) do
    isbn_list = String.split(isbn, "", trim: true)
    
    digits = 
    Enum.take(isbn_list, 9)
    |> Enum.map(&String.to_integer/1)
    
    last_char = Enum.take(isbn_list, -1)

    check =
    case List.first(last_char) do
      "X" -> 10
      _ -> String.to_integer(List.first(last_char))
    end
    
    digits ++ [check]
    |> Enum.zip(10..1)
    |> Enum.map(fn {val, multiple} -> val * multiple end)
    |> Enum.sum()
    |> rem(11) == 0
  end

  defp parse_string(isbn) do
    String.replace(isbn, "-", "")
  end

  defp valid?(isbn) do
    with true <- String.length(isbn) == 10,
         true <- String.match?(String.slice(isbn, 0..8), ~r/^[0-9]+$/),
         true <- String.last(isbn) =~ ~r/[0-9X]/ do
      true
    end
  end
end