defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """

  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    rows = generate_rows(board)
    grid = generate_rows(board) ++ generate_columns(rows) ++ generate_diagonals(rows)

      
    case open_board(board) do
      true -> check_incompleted_state(grid, board)
      false -> check_completed_state(grid)
    end

  end

  defp open_board(board) do
    String.contains?(board, ".")
  end

  defp check_incompleted_state(grid, board) do
    moves = String.split(board, "", trim: true) |> Enum.filter(fn val -> String.match?(val, ~r/[XO]/) end) |> Enum.frequencies
    player2 = Map.get(moves, "O", 0)
    player1 = Map.get(moves, "X", 0)
    
    cond do
    player2 > player1 ->
      {:error, "Wrong turn order: O started"}
    player1 - player2 > 1 ->
      {:error, "Wrong turn order: X went twice"}
    true -> 
      win = 
      grid
      |> Enum.filter(fn set -> set == ["X", "X", "X"] or set == ["O", "O", "O"] end) 
      |> Enum.uniq 
      |> Enum.count
  
      case win do
        0 -> {:ok, :ongoing}
        1 -> {:ok, :win}
        _ -> {:error, "Impossible board: game should have ended after the game was won"}
      end
    end
  end

  defp check_completed_state(grid) do
    win = 
    grid
    |> Enum.filter(fn set -> set == ["X", "X", "X"] or set == ["O", "O", "O"] end) 
    |> Enum.uniq 
    |> Enum.count

    case win do
      0 -> {:ok, :draw}
      1 -> {:ok, :win}
      _ -> {:error, "Impossible board: game should have ended after the game was won"}
    end
  end


  defp generate_rows(board) do
    board |> String.split("\n", trim: true) |> Enum.map(fn row -> String.split(row, "", trim: true) end)
  end

  defp generate_columns(rows) do
    Enum.zip(rows) |> Enum.map(&Tuple.to_list/1)
  end

  defp generate_diagonals(rows) do
    reversed_rows = Enum.reverse(rows)
    diagonal1 = Enum.reduce(Enum.with_index(rows), [], fn {row, i}, acc -> [Enum.at(row, i) | acc] end)
    diagonal2 = Enum.reduce(Enum.with_index(reversed_rows), [], fn {row, i}, acc -> [Enum.at(row, i) | acc] end)

    [diagonal1 , diagonal2]
  end
end
