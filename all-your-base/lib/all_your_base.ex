defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}
 
  def convert(digits, input_base, output_base) do
    if valid_digits(digits, input_base) do
      result = case output_base do
        10 ->
          convert_to_decimal(digits, input_base)
          |> Integer.digits()
        _ ->
          convert_to_output_base(digits, input_base, output_base)
        end
      
      {:ok, result}
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp valid_digits(digits, input_base) do
    Enum.all?(digits, fn digit -> digit >= 0 and digit < input_base end)
  end

  defp convert_to_decimal(digits, 10), do: Integer.undigits(digits)
  
  defp convert_to_decimal(digits, input_base) do
    Enum.reverse(digits)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, power}, acc ->
      acc + digit * (input_base**power) 
    end)
  end

  defp convert_from_decimal(number, output_base, units) do
    quotient = div(number, output_base)
    remainder = rem(number, output_base)
    units = [remainder | units]
    cond do
      quotient > 0 ->
        convert_from_decimal(quotient, output_base, units)
      true ->
        units
    end
  end

  defp convert_to_output_base(digits, input_base, output_base) do
    convert_to_decimal(digits, input_base)
    |> convert_from_decimal(output_base, [])
  end
end
