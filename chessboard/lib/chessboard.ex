defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    Chessboard.rank_range
    |> Range.to_list()
  end

  def files do
    Chessboard.file_range
    |> Range.to_list()
    |> Enum.map(fn codepoint -> <<codepoint>> end)
  end
end
