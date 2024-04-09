defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError, "Count must be greater than 0")
  def nth(1), do: 2
  def nth(count) do
    list_primes() |> Enum.at(count - 1)
  end

  defp list_primes() do
    Stream.iterate(1, &(&1 + 1)) 
    |> Stream.filter(&prime?/1)
  end

  defp prime?(num) do
    2..(trunc(:math.sqrt(num)) + 1)
    |> Enum.all?(fn val -> rem(num, val) != 0 end)
  end
end
