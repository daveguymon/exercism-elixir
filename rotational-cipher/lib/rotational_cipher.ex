defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text_list = String.split(text, "", trim: true)
    for letter <- text_list do
      char = String.to_charlist(letter) |> hd
      
      shifted_ascii_value = shift_letters(char, shift)

      cond do
        needs_wrapped?(char, shifted_ascii_value) -> 
          shifted_ascii_value - 26
        true -> 
          shifted_ascii_value
      end
    end
    |> List.to_string()
  end

  defp shift_letters(char, shift) when char in ?a..?z or char in ?A..?Z, do: char + shift
  defp shift_letters(char, _), do: char

  defp needs_wrapped?(char, shifted_ascii_value) do
    char in ?a..?z and shifted_ascii_value > ?z or char in ?A..?Z and shifted_ascii_value > ?Z
  end
end
