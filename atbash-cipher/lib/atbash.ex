defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @cipher_key Enum.zip(?a..?z, ?z..?a) |> Enum.into(%{})
  
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> parse_decoded
    |> do_translation
    |> format_encoded
  end

  defp parse_decoded(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist
  end

  defp do_translation(characters) do
    characters
    |> Enum.reduce([], fn char, acc -> 
      if Map.has_key?(@cipher_key, char) do
        [Map.get(@cipher_key, char) | acc]
      else 
        [char | acc]
      end
    end)
  end

  defp format_encoded(encoded) do
    encoded
    |> Enum.reverse
    |> Enum.chunk_every(5)
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> parse_encoded
    |> do_translation
    |> format_decoded
  end

  defp parse_encoded(cipher) do
    cipher
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist
  end

  defp format_decoded(decoded) do
    decoded
    |> Enum.reverse
    |> to_string
  end
end
