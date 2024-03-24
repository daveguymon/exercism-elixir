defmodule DNA do
  @cp_map  %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }
  def encode_nucleotide(code_point) do
    Map.get(@cp_map, code_point)
  end

  def decode_nucleotide(encoded_code) do
   pair = Map.filter(@cp_map, fn {_key, value} -> value == encoded_code end)
   [key | _] = Map.keys(pair)

   key
  end

  def encode(dna) do
    do_encoding(dna, <<>>)
  end

  defp do_encoding([], acc), do: acc

  defp do_encoding([nucleotide | rest], acc) do
    literal = encode_nucleotide(nucleotide)
    new_acc = <<acc::bitstring, literal :: size(4)>>
    do_encoding(rest, new_acc)
  end

  def decode(dna) do
    do_decoding(dna, [])
  end

  defp do_decoding("", list), do: list
  
  defp do_decoding(<<value::4, rest::bitstring>>, list) do
    decoded = decode_nucleotide(value)
    new_list = list ++ [decoded]
    do_decoding(rest, new_list)
  end
end
