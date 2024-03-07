defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @unequal_length_error {:error, "strands must be of equal length"}

  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance([], []) do
    {:ok, 0}
  end
 
  def hamming_distance([], _strand2) do
    @unequal_length_error
  end
  
  def hamming_distance(_strand1, []) do
    @unequal_length_error
  end

  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    @unequal_length_error
  end

  def hamming_distance(strand1, strand2) do
    differences = (Enum.zip(strand1, strand2)
    |> Enum.reject(fn {val1, val2} -> val1 == val2 end))
    
    {:ok, length(differences)}
  end
end
