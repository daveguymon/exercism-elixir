defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when not is_integer(count) or count < 1 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end

  def generate(1), do: [2]

  def generate(2), do: [2,1]

  def generate(count) when count > 2 do
    base = [2,1]

    next_fun = fn base ->
      new_node = Enum.sum(Enum.take(base, -2))
      [new_node | Enum.reverse(base)]
      |> Enum.reverse()
    end

    Stream.iterate(base, next_fun)
    |> Stream.take(count - 1)
    |> Enum.at(-1)
  end
end
