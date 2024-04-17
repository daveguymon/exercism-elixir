defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string), do: do_encoding(String.split(string, "", trim: true), [])

  defp do_encoding([], frequencies) do 
    Enum.reverse(frequencies)
    |> Enum.reduce("", fn {freq, character}, acc -> 
      if(freq > 1, do: acc <> Integer.to_string(freq) <> character, else: acc <> character) 
    end)
  end

  defp do_encoding([hd | chars], []), do: do_encoding(chars, [{1, hd}])
  defp do_encoding([hd | chars], [{freq, current} | rest]) when hd == current, do: do_encoding(chars, [{freq + 1, current} | rest])
  defp do_encoding([hd | chars], [{_freq, current} | _rest] = frequencies) when hd != current, do: do_encoding(chars, [{1, hd} | frequencies])

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r/\d*[A-Za-z\s]/, string)
    |> Enum.map(fn pair -> 
      case Integer.parse(List.first(pair)) do
        :error -> 
          {1, List.first(pair)}
        {num, char} ->
          {num, char} 
      end
    end)
    |> do_formatting("")
  end

  defp do_formatting([], string), do: string
  defp do_formatting([tuple | rest], string) do
    updated_string = build_string(elem(tuple, 0), elem(tuple, 1), string)
    do_formatting(rest, updated_string)
  end

  defp build_string(0, _, string), do: string
  defp build_string(number, character, string) do
    build_string(number - 1, character, string <> character)
  end
end
