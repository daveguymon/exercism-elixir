defmodule CollatzConjecture do
  import Integer, only: [is_even: 1]
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input), do: calc(input, 0)
  
  defp calc(input, times) when is_integer(input) and input > 0, do: calc_step(input, times)

  defp calc_step(1, times), do: times
  defp calc_step(input, times) do
    next_value = if is_even(input), do: compute_even(input), else: compute_odd(input)
    
    calc(next_value, times + 1)
  end

  defp compute_odd(input), do: 3 * input + 1
  defp compute_even(input), do: div(input, 2)
end
