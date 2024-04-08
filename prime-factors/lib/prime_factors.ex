defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]

  
  def factors_for(number) do
    do_factoring(number, 2, [])
  end

  defp do_factoring(1, _, factors), do: factors
  defp do_factoring(number, divisor, factors) when divisor * divisor > number, do: factors ++ [number]
  defp do_factoring(number, divisor, factors) do
    case rem(number, divisor) do
      0 ->
        do_factoring(div(number, divisor), divisor, factors ++ [divisor])
      _ ->
        do_factoring(number, divisor + 1, factors)
    end
  end
end
