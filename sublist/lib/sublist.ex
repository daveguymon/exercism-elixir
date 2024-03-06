defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []) do
    :equal
  end
  
  def compare([], _b) do
    :sublist
  end

  def compare(_a, []) do
    :superlist
  end

  def compare(a,b) when length(a) == length(b), do: check_for_equality(a,b)

  def compare(a,b) when length(a) > length(b), do: check_for_superlist(a,b)
  
  def compare(a,b) when length(a) < length(b), do: check_for_sublist(a,b)

  defp check_for_equality(a, b) do
    if a == b, do: :equal, else: :unequal
  end

  defp check_for_superlist(a, b) do
    if sliding_chunks(a,b) == true, do: :superlist, else: :unequal
  end

  defp check_for_sublist(a, b) do
    if sliding_chunks(b,a) == true, do: :sublist, else: :unequal
  end

  defp sliding_chunks(a, b) do
    Enum.chunk_every(a, length(b), 1, :discard)
    |> Enum.any?(fn chunk -> chunk === b end)
  end
end
