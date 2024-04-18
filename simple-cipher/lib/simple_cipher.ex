defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """

  def encode(plaintext, key) do
    String.to_charlist(plaintext)
    |> Enum.zip(generate_key_sequence(plaintext, key, ""))
    |> Enum.map(fn {original, key} -> 
      do_encoding(original, key)
    end)
    |> List.to_string()
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    String.to_charlist(ciphertext)
    |> Enum.zip(generate_key_sequence(ciphertext, key, ""))
    |> Enum.map(fn {original, key} -> 
      do_decoding(original, key)
    end)
    |> List.to_string()
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    do_generate_key(length, [])
    |> List.to_string()
  end

  defp do_generate_key(length, key) when length > 26 do
    do_generate_key(length - 26, [Enum.take_random(?a..?z, length) | key])
  end

  defp do_generate_key(length, key) when length <= 26 do
    [Enum.take_random(?a..?z, length) | key]
  end

  defp generate_key_sequence(plaintext, key, sequence) do
    case {String.length(sequence), String.length(plaintext)} do
      {len1, len2} when len1 > len2 ->
        String.slice(sequence, 0..(len2 - 1))
        |> String.to_charlist()
      _ ->
        generate_key_sequence(plaintext, key, sequence <> key)
    end
  end

  defp do_encoding(val, key_value) do
    shift_value = key_value - ?a 
    cond do 
      val + shift_value <= ?z ->
        val + shift_value
      true -> 
        val + shift_value - 26
    end
  end

  defp do_decoding(val, key_value) do
    shift_value = key_value - ?a 
    cond do 
      val - shift_value >= ?a ->
        val - shift_value
      true -> 
        val - shift_value + 26
    end
  end
end
