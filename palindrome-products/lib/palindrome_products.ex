defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise(ArgumentError)
  def generate(max_factor, min_factor) do
    palindrome_products = 
    generate_products(max_factor, min_factor)
    |> Enum.filter(&palindrome?/1)
    |> Enum.sort
    
    if palindrome_products == [] do
      %{}
    else
      min_max_products = find_min_max_products(palindrome_products)
      factors = get_factors_within_range(max_factor, min_factor, min_max_products)

      Enum.zip(min_max_products, factors)
      |> Enum.into(%{})
    end
  end

  defp generate_products(max_factor, min_factor) do
    for num1 <- min_factor..max_factor,
        num2 <- min_factor..max_factor,
        num1 <= num2 do
          num1 * num2
        end
        |> Enum.uniq
  end

  defp palindrome?(number) do
    string = Integer.to_string(number)
    string == String.reverse(string)
  end

  defp find_min_max_products(list) do
    [List.first(list), List.last(list)]
  end

  defp get_factors_within_range(max_factor, min_factor, [min_product, max_product]) do
    min_factors = factors_for_product(min_product, min_factor, max_factor)
    max_factors = factors_for_product(max_product, min_factor, max_factor)

    [min_factors, max_factors]
  end

  defp factors_for_product(product, min_factor, max_factor) do
    for i <- min_factor..max_factor,
      rem(product, i) == 0,
      j = div(product, i),
      j >= min_factor,
      j <= max_factor do 
        {i, j}
      end
      |> Enum.map(fn factor -> 
        factor
        |> Tuple.to_list
        |> Enum.sort
      end)
    |> Enum.uniq
  end
end
