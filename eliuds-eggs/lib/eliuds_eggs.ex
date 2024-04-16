defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  
  def egg_count(0), do: 0
  def egg_count(number) when number > 0 do
    do_division_by_two(number, [])
    |> Enum.reduce(&+/2)
  end

  defp do_division_by_two(1, bits), do: [1 | bits] 
  defp do_division_by_two(number, bits) do
    do_division_by_two(div(number, 2), [rem(number, 2) | bits])
  end
end
