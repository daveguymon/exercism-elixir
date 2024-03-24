defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _fun), do: []
  
  def keep(list, fun) do
    list
    |> Enum.flat_map(fn val -> 
      if(fun.(val), do: [val], else: [])
    end)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _fun), do: []
  
  def discard(list, fun) do
    list
    |> Enum.flat_map(fn val -> 
      if(fun.(val), do: [], else: [val])
    end)
  end
end
