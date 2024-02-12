defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> is_nil(item.price) end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item -> Map.replace(item, :name, Regex.replace(~r/#{old_word}/, item.name, new_word)) end)
  end

  def increase_quantity(item, count) do
    %{item | quantity_by_size: Enum.into(Enum.map(item.quantity_by_size, fn {size, qty} -> {size, qty + count} end), %{})}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_size, qty}, acc -> qty + acc end)
  end
end
