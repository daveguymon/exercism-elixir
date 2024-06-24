defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()  
  def new(opts \\ []) do
    case valid_input(opts) do
      true -> %Queens{:white => opts[:white], :black => opts[:black]}
      _ -> raise ArgumentError
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    white = Map.get(queens, :white)
    black = Map.get(queens, :black)

    for col <- 0..7, row <- 0..7 do
      cond do
        {col, row} == white ->
          "W"
        {col, row} == black -> 
          "B"
        true -> "_"
      end
    end
    |> Enum.chunk_every(8)
    |> Enum.map(fn row -> Enum.join(row, " ") end)
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    [_, q1, q2] = Map.values(queens)
    queens_present = not is_nil(q1) and not is_nil(q2)
    
    case queens_present do
      true -> do_attack(queens)
      _ -> false
    end
  end

  defp do_attack(queens) do
    same_row_or_column?(queens) or
    same_diagonal?(queens)
  end

  defp same_diagonal?(queens) do
    [_, queen1, queen2] = Map.values(queens)

    Enum.member?(all_diagonals(queen1), queen2)
  end

  defp all_diagonals({col, row}) do
    primary_diagonal({col, row}) ++ secondary_diagonal({col, row})
  end

  defp primary_diagonal({col,row}) do
    diagonal_up(col, row, []) ++ diagonal_down(col, row, [])
  end

  defp diagonal_up(i, j, acc) when i <= 0 or j <= 0, do: acc
  defp diagonal_up(i, j, acc) do
    diagonal_up(i - 1, j - 1, [{i - 1, j - 1} | acc])
  end

  defp diagonal_down(k, l, acc) when k >= 7 or l >= 7, do: acc
  defp diagonal_down(k, l, acc) do
    diagonal_down(k + 1, l + 1, [ {k + 1, l + 1}| acc])
  end

  defp secondary_diagonal({col, row}) do
    secondary_up(col, row, []) ++ secondary_down(col, row, [])
  end

  defp secondary_up(i, j, acc) when i >= 7 or j <= 0, do: acc
  defp secondary_up(i, j, acc) do
    secondary_up(i + 1, j - 1, [{i + 1, j - 1} | acc])
  end

  defp secondary_down(i, j, acc) when i <= 0 or j >= 7, do: acc
  defp secondary_down(i, j, acc) do
    secondary_down(i - 1, j + 1, [{i - 1, j + 1} | acc])
  end

  defp same_row_or_column?(queens) do
    case Enum.any?(Map.values(queens), fn value -> value == nil end) do
      false -> do_same_row_or_column(queens)
      _ -> false
    end
  end

  defp do_same_row_or_column(queens) do
    [_, {c1, r1}, {c2, r2}] = Map.values(queens)
    c1 == c2 or r1 == r2
  end

  defp valid_input(opts) do
    opts
    |> Enum.map(&validate_square/1)
    |> Enum.all?(&(&1 == true)) and
    different_squares(opts)
  end

  defp different_squares(opts) do
    coordinates = Enum.map(opts, fn {_, square} -> square end)
    coordinates_set = MapSet.new(coordinates)

    length(coordinates) == MapSet.size(coordinates_set)
  end

  defp validate_square({color, {x,y}}) do
    color in [:white, :black] and
    x in 0..7 and
    y in 0..7
  end
end
