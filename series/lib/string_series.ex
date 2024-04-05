defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(str, size) do 
    cond do 
      slicable?(str, size) -> 
        do_slicing(str, size)
      true ->
        []
    end
  end

  defp slicable?(str, size) do
    String.length(str) >= size and size > 0
  end

  defp do_slicing(str, size) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.reduce([], fn chunk, acc -> acc ++ [Enum.join(chunk, "")] end)
  end
end
