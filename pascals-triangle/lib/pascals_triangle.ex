defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(count) do
     row_numbers = 1..count
     for row_number <- row_numbers do
      generate_row(row_number)
     end
  end

  defp calculate_term(_, 0), do: 1
  defp calculate_term(row, index) when row == index, do: 1
  defp calculate_term(row, index) do
    n = do_factorial(row)
    k = do_factorial(index) * do_factorial(row - index)
    div(n, k)
  end

  defp do_factorial(val) do
    Enum.reduce(1..val, fn num, acc -> acc * num end)
  end

  defp generate_row(count) do
    rows = count - 1
    columns = 0..rows

    for row <- [rows], column <- columns do
      calculate_term(row, column)
    end
  end
end
