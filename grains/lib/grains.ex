defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  
  def square(number) when number not in (1..64), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  def square(number), do: {:ok, calculate_grains_of_rice(number)}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    sum = Enum.reduce((1..64), fn number, acc -> 
      acc + calculate_grains_of_rice(number)
    end)
    
    {:ok, sum}
  end

  defp calculate_grains_of_rice(number) do
    Integer.pow(2, number - 1)
  end
end
