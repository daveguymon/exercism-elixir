defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    cleansed_factors(limit, factors)
    |> Stream.flat_map(&(generate_multiples(limit, &1, [&1])))
    |> Stream.uniq()
    |> Enum.sum()
  end

  defp cleansed_factors(limit, factors) do
    factors
    |> Enum.filter(&(&1 > 0 and &1 < limit))
  end

  defp generate_multiples(limit, val, list) when hd(list) >= limit - val, do: list
  defp generate_multiples(limit, val, list), do: generate_multiples(limit, val, [hd(list) + val | list])
end
