defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> validate_format()
    |> remove_non_numeric()
    |> validate_length_and_contents()
    |> check_area_and_exchange_codes()
  end

  defp validate_format(raw) do
    if Regex.match?(~r/[^0-9+\-.\s()]/, raw) do
      {:error, "must contain digits only"}
    else
      {:ok, raw}
    end
  end

  defp remove_non_numeric({:ok, str}) do
    {:ok, Regex.replace(~r/\D/, str, "")}
  end

  defp remove_non_numeric(error), do: error
  

  defp validate_length_and_contents({:ok, str}) do
    case String.length(str) do
      n when n > 11 -> {:error, "must not be greater than 11 digits"}
      n when n < 10 -> {:error, "must not be fewer than 10 digits"}
      11 -> if String.starts_with?(str, "1"), do: {:ok, String.slice(str, 1..-1)}, else: {:error, "11 digits must start with 1"}
      10 -> {:ok, str}
    end
  end

  defp validate_length_and_contents(error), do: error

  defp check_area_and_exchange_codes({:ok, str}) do
    area_code_start = String.at(str, 0)
    exchange_code_start = String.at(str, 3)

    cond do
      area_code_start == "0" -> {:error, "area code cannot start with zero"}
      area_code_start == "1" -> {:error, "area code cannot start with one"}
      exchange_code_start == "0" -> {:error, "exchange code cannot start with zero"}
      exchange_code_start == "1" -> {:error, "exchange code cannot start with one"}
      true -> {:ok, str}
    end
  end

  defp check_area_and_exchange_codes(error), do: error
end
