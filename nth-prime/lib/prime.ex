defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError, "Count must be greater than 0"
  def nth(count) do
    list_primes(count, 2, [])
  end
  
  defp list_primes(count, _num, list) when length(list) == count, do: List.last(list)
  defp list_primes(count, num, list) do
    list = 
    if prime?(num) do
      list ++ [num]
    else
      list
    end
    
    list_primes(count, num + 1, list)
  end

  defp prime?(num) do
    factors = 
    Enum.filter(2..num, fn dividend -> 
      rem(num, dividend) == 0 
    end)

    length(factors) == 1
  end
end
