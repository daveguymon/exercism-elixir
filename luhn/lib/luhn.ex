defmodule Luhn do
  require Integer
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  
  def valid?(number) do
    case validate_input(number) do
      true -> 
        do_valid(number)
      false -> 
        false
    end
  end

  defp do_valid(string) do
    string
    |> format_list()
    |> process_list()
    |> compute()
  end

  defp validate_input(string) do
    parsed_input = String.replace(string, ~r/\s+/, "")
    cond do 
      String.length(parsed_input) < 2 ->
        false
      String.match?(parsed_input, ~r/[^\d]/) ->
        false
      true -> true
    end
  end

  defp format_list(string) do
    string
    |> String.replace(~r/\D/, "")
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
  end

  defp process_list(list) do
    list
    |> Enum.with_index()
    |> Enum.map(fn {integer, index} -> 
      cond do
        Integer.is_odd(index) and integer * 2 > 9 -> integer * 2 - 9
        Integer.is_odd(index) -> integer * 2
        true -> integer
      end
    end)
  end

  defp compute(integer) do
    integer
    |> Enum.sum()
    |> rem(10) == 0
  end
end
