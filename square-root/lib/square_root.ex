defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    [root] = (1..div(radicand, 2))
    |> Enum.filter(fn num -> num * num == radicand end)

    root
  end
end
