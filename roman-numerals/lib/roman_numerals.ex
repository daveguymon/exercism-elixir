defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @symbols [{1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"}, {100, "C"}, {90, "XC"},
  {50, "L"}, {40, "XL"}, {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}]

  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: do_conversion(number, "")

  defp do_conversion(0, result), do: result
  defp do_conversion(number, result) do
    {value, symbol} = Enum.find(@symbols, fn {value, _symbol} -> value <= number end)
    do_conversion(number - value, result <> symbol)
  end
end
