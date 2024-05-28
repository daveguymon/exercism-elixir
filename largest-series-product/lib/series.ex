defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if invalid_string(number_string, size) do
      raise(ArgumentError)
    else
      number_string
      |> String.split("", trim: true)
      |> Stream.map(&String.to_integer/1)
      |> Stream.chunk_every(size, 1, :discard)
      |> Stream.map(&Enum.product/1)
      |> Enum.max
    end
  end

  defp invalid_string(number_string, size) do
    number_string == "" or 
    size < 1 or 
    !String.match?(number_string, ~r/^\d+$/) or 
    size > String.length(number_string)
  end
end
