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

  defp update_item(item) do
    item
    |> update_item_quality()
    |> update_item_sell_in()
  end

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in} = item)
       when sell_in <= 0 do
    Map.put(item, :quality, 0)
  end

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in, quality: quality} = item)
       when sell_in <= 5 do
    Map.put(item, :quality, increase_quality(quality, 3))
  end

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in, quality: quality} = item)
       when sell_in <= 10 do
    Map.put(item, :quality, increase_quality(quality, 2))
  end

  defp update_item_quality(%Item{name: @backstage, quality: quality} = item) do
    Map.put(item, :quality, increase_quality(quality, 1))
  end

  defp update_item_quality(%Item{name: @brie, quality: quality} = item) do
    Map.put(item, :quality, increase_quality(quality, 1))
  end

  defp update_item_quality(%Item{quality: quality} = item) when quality == 0 do
    item
  end

  defp update_item_quality(%Item{quality: quality} = item) do
    Map.put(item, :quality, decrease_quality(quality, 1))
  end

  defp increase_quality(quality, _amt) when quality >= 50, do: quality

  defp increase_quality(quality, amt), do: quality + amt

  defp decrease_quality(quality, _amt) when quality == 0, do: 0

  defp decrease_quality(quality, amt), do: quality - amt

  defp update_item_sell_in(%Item{sell_in: sell_in} = item) do
    Map.put(item, :sell_in, sell_in - 1)
  end
end
