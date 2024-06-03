defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    Enum.sum(triplet)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    triplet 
    |> Enum.reduce(1, &*/2)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    (a < b and b < c) and (a**2 + b**2 == c**2)
  end

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum) do
    side_a_range = 1..div(sum, 3)
    side_b_range = generate_side_b_range(side_a_range, sum)
    sets = Enum.zip(side_a_range, side_b_range) |> Enum.map(&Tuple.to_list/1)
    hypoteneuse_range = generate_hypoteneuse_range(sets, sum)

    range_sets = 
    Enum.zip(sets, hypoteneuse_range)
    |> Enum.map(fn {[hd | tail], last} -> 
      [hd**2, Enum.map(List.flatten(tail), &(&1**2)), Enum.map(last, &(&1**2))] 
    end)

    range_sets
    |> generate_triplets
    |> filter_pythagorean_triplets(sum)
    |> get_square_root
  end

  defp generate_side_b_range(side_a_range, sum) do
    for val <- side_a_range do
      Enum.to_list((val + 1)..div(sum, 2))
    end
  end

  defp generate_hypoteneuse_range(sets, sum) do
    for [a, bs] <- sets do
      Enum.map(bs, fn b -> sum - a - b end)
    end
  end

  defp generate_triplets(range_sets) do
    for [a, b_list, c_list] <- range_sets, {b, c} <- Enum.zip(b_list, c_list) do
      [a, b, c]
    end
  end

  defp filter_pythagorean_triplets(triplets, sum) do
    triplets
    |> Enum.map(&Enum.sort/1)
    |> Enum.filter(fn [a, b, c] -> 
      a**0.5 + b**0.5 + c**0.5 == sum and a + b == c
    end)
    |> Enum.uniq
  end

  defp get_square_root(pythagorean_triplets) do
    for triplet <- pythagorean_triplets do
      for square <- triplet do
        round(square**0.5)
      end
    end
  end
end
