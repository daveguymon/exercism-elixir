defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str 
    |> normalized 
    |> generate_square
  end

  defp normalized(str) do
    str
    |> String.downcase
    |> String.split("", trim: true) 
    |> Enum.filter(&String.match?(&1, ~r/[a-z0-9]/)) 
    |> Enum.join("")
  end

  defp generate_square(""), do: ""
  defp generate_square(str) do
    sqrt = ceil(String.length(str) ** 0.5)  

    str 
    |> String.split("", trim: true) 
    |> Enum.chunk_every(sqrt, sqrt, List.duplicate(" ", sqrt - 1)) 
    |> Enum.zip 
    |> Enum.map(&Tuple.to_list/1) 
    |> Enum.map(&Enum.join/1) 
    |> Enum.join(" ")
  end
end
