defmodule GildedRose.Inventory do
  alias GildedRose.Item

  defstruct items: []

  @brie "Aged Brie"
  @backstage "Backstage passes to a TAFKAL80ETC concert"

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

  defp update_item(%Item{name: @backstage, sell_in: sell_in, quality: quality} = item) do
    Map.put(item, :sell_in, sell_in - 1)
    |> Map.put(:quality, quality + 1)
  end

  defp update_item(%Item{name: @brie, sell_in: sell_in, quality: quality} = item) do
    Map.put(item, :sell_in, sell_in - 1)
    |> Map.put(:quality, quality + 1)
  end

  defp update_item(%Item{sell_in: sell_in, quality: quality} = item) do
    Map.put(item, :sell_in, sell_in - 1)
    |> Map.put(:quality, quality - 1)
  end
end
