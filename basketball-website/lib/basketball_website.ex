defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    String.split(path, ".")
    |> search_map(data)
  end

  defp search_map([head | tail], data) do
    if Enum.empty?(tail), do: data[head], else: search_map(tail, data[head])
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
