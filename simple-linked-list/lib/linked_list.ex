defmodule LinkedList do
  @opaque t :: tuple()
  # defstruct [:head, :tail]

  defmodule ListNode do
    defstruct [:data, :next]
  end

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: %ListNode{}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  
  def push(%ListNode{data: nil} = list, elem), do: %{list | data: elem}
  def push(list, elem), do: do_prepend(list, %ListNode{data: elem})

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(nil), do: 0
  def count(list), do: do_counting(list, 0)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(%ListNode{data: data}), do: is_nil(data)

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(nil), do: {:error, :empty_list}
  def peek(%ListNode{data: nil, next: nil}), do: {:error, :empty_list}
  def peek(%ListNode{data: data}), do: {:ok, data}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(nil), do: {:error, :empty_list}
  def tail(%ListNode{data: nil, next: nil}), do: {:error, :empty_list}
  def tail(%ListNode{next: next}), do: {:ok, next}
  
  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(nil), do: {:error, :empty_list}
  def pop(%ListNode{data: data, next: next}), do: {:ok, data, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t  
  def from_list(list) do
    LinkedList.new
    |> do_push_from_list(Enum.reverse(list))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(%ListNode{data: nil, next: nil}), do: []
  def to_list(linked_list), do: do_append_data_to_list(linked_list, [])


  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse([]), do: {:error, :empty_list}
  def reverse(linked_list), do: do_reversal(LinkedList.new, linked_list)


  defp do_append_data_to_list(nil, list), do: list
  defp do_append_data_to_list(linked_list, list) do
    {:ok, element, linked_list} = LinkedList.pop(linked_list)
    do_append_data_to_list(linked_list, list ++ [element])
  end

  defp do_counting(%ListNode{data: nil}, counter), do: counter
  defp do_counting(%ListNode{next: nil}, counter), do: counter + 1
  defp do_counting(%ListNode{next: next}, counter), do: do_counting(next, counter + 1)

  defp do_prepend(list, new_node), do: %{new_node | next: list}

  defp do_push_from_list(linked_list, []), do: linked_list
  defp do_push_from_list(linked_list, [head | rest]) do
    linked_list
    |> LinkedList.push(head)
    |> do_push_from_list(rest)
  end

  defp do_reversal(reversed_list, nil), do: reversed_list
  defp do_reversal(reversed_list, linked_list) do
    {:ok, data, rest} = LinkedList.pop(linked_list)
    LinkedList.push(reversed_list, data)
    |> do_reversal(rest)
  end
end
