defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    (output = code
    |> Integer.digits(2)
    |> Enum.slice(-5..-1)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce([], fn {bit, index}, acc -> 
      case {bit, index} do
        {1, 0} -> ["wink" | acc]
        {1, 1} -> ["double blink" | acc]
        {1, 2} -> ["close your eyes" | acc]
        {1, 3} -> ["jump" | acc]
        {1, 4} -> Enum.reverse(acc)
        _ -> acc
      end
    end
    ))
    Enum.reverse(output)
  end
end
