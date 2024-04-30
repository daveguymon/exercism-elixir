defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:yacht, dice), do: yacht(dice)
  def score(:ones, dice), do: same_number_frequency(1, dice)
  def score(:twos, dice), do: same_number_frequency(2, dice)
  def score(:threes, dice), do: same_number_frequency(3, dice)
  def score(:fours, dice), do: same_number_frequency(4, dice)
  def score(:fives, dice), do: same_number_frequency(5, dice)
  def score(:sixes, dice), do: same_number_frequency(6, dice)
  def score(:full_house, dice), do: full_house(dice)
  def score(:four_of_a_kind, dice), do: four_of_a_kind(dice)
  def score(:little_straight, dice), do: little_straight(dice)
  def score(:big_straight, dice), do: big_straight(dice)
  def score(:choice, dice), do: Enum.sum(dice)


  defp yacht(dice) do
    if Enum.all?(dice, fn roll -> roll == hd(dice) end) do
      50
    else
      0
    end
  end

  defp same_number_frequency(num, dice) do
    freqs = Enum.frequencies(dice)
            |> Map.get(num)
    
    if is_nil(freqs) do 
      0
    else 
      num * freqs
    end
  end

  defp full_house(dice) do
    number_groups = 
    dice
    |> Enum.group_by(&(&1))
    |> Map.values

    with 2 <- Enum.count(number_groups),
         true <- Enum.all?(number_groups, fn val -> Enum.count(val) in 2..3 end) do
      number_groups
      |> List.flatten
      |> Enum.sum
    else
      _ -> 0
    end
  end

  defp four_of_a_kind(dice) do
    dice
    |> Enum.frequencies
    |> Map.to_list
    |> Enum.reduce(0, fn {val, freq}, acc ->  
      if freq >= 4 do 
        4 * val + acc
      else
        acc
      end
    end)
  end

  defp little_straight(dice) do
    if Enum.sort(dice) == Enum.to_list(1..5) do
      30
    else
      0
    end
  end

  defp big_straight(dice) do
    if Enum.sort(dice) == Enum.to_list(2..6) do
      30
    else
      0
    end
  end
end
