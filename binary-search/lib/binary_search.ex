defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, _key) when numbers == {}, do: :not_found  

  def search(numbers, key) when tuple_size(numbers) == 1 and elem(numbers, 0) != key, do: :not_found

  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(numbers, key, low, high) when low <= high do
    middle = div(low + high, 2)
    middle_value = elem(numbers, middle)

    case middle_value do
      ^key -> {:ok, middle}
      _ when middle_value > key -> search(numbers, key, 0, middle - 1)
      _ -> search(numbers, key, middle + 1, high)
    end
  end

  defp search(_, _, _, _) do
    :not_found
  end
end
