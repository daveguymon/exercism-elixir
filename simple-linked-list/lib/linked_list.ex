defmodule LinkedList do
  @opaque t :: tuple()
  # defstruct [:head, :tail]

  defmodule ListNode do
    defstruct data: nil, next: nil
  end
  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %ListNode{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  
  def push(list, elem) when is_nil(list.data) do
    %{list | data: elem}
  end

  def push(list, elem) do
    append(list, %ListNode{data: elem})
  end

  defp append(nil, new_node), do: new_node

  defp append(list, new_node)do
    %{list | next: append(list.next, new_node)}
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list) do
    do_counting(list, 0)
  end

  defp do_counting(list, counter) when is_nil(list.data), do: counter
  defp do_counting(list, counter) when not is_nil(list.data) and is_nil(list.next), do: counter + 1
  defp do_counting(list, counter), do: do_counting(list.next, counter + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    is_nil(list.data)
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    # Your implementation here...
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    # Your implementation here...
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    # Your implementation here...
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    # Your implementation here...
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    # Your implementation here...
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    # Your implementation here...
  end
end
