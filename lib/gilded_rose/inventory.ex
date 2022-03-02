defmodule GildedRose.Inventory do
  defstruct items: []

  def new(items) do
    %__MODULE__{items: items}
  end

  def update_quality(%__MODULE__{items: items} = inventory) do
    items = update_items(items)
    Map.put(inventory, :items, items)
  end

  defp update_items(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(item) do
    item
  end
end
