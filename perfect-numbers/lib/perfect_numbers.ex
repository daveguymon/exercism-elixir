defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(1), do: {:ok, :deficient}
  def classify(number) do
    aliquot_sum = sum_factors(number)

    cond do
      number > aliquot_sum ->
        {:ok, :deficient}
      number < aliquot_sum -> 
        {:ok, :abundant}
      true -> 
        {:ok, :perfect}
    end
  end

  defp sum_factors(number) do    
    Enum.reduce(1..Integer.floor_div(number, 2), fn val, acc -> 
      if rem(number, val) == 0 do
        acc + val
      else
        acc
      end
    end)
  end
end
