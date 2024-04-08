defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    result = 
    Integer.digits(number)
    |> Enum.reduce(0, fn digit, acc -> 
      acc + (Integer.pow(digit, length(Integer.digits(number)))) 
    end)

    number == result
  end
end

