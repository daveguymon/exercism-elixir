defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @allergens %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats"
  }

  @spec list(non_neg_integer) :: [String.t()]
  def list(flags), do: do_list(flags, [])

  defp do_list(0, list), do: list
  defp do_list(flags, list) do
    flag = find_largest_flag(flags, 0, 1)
    
    list = case Map.has_key?(@allergens, flag) do
      true ->
        [Map.get(@allergens, flag) | list]
      false -> 
        list
    end

    do_list(flags - flag, list)
  end

  defp find_largest_flag(flags, pot, next_pot) when flags > 0 do
    case flags >= Integer.pow(2, next_pot) do
      true ->
        find_largest_flag(flags, pot + 1, next_pot + 1)
      false -> 
        Integer.pow(2, pot)
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    Allergies.list(flags)
    |> Enum.any?(fn flag -> flag == item end)
  end
end
