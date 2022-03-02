defmodule GildedRose.Inventory do
  alias GildedRose.Item

  defstruct items: []

  @brie "Aged Brie"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"
  @conjured "Conjured Mana Cake"

  @decay_rate 1
  @accelerated_decay 2

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

  defp update_item_quality(%Item{name: @sulfuras} = item), do: item

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in} = item)
       when sell_in <= 0 do
    Map.put(item, :quality, 0)
  end

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 5 do
    increase_quality(item, 3)
  end

  defp update_item_quality(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 10 do
    increase_quality(item, 2)
  end

  defp update_item_quality(%Item{name: @backstage} = item) do
    increase_quality(item, @decay_rate)
  end

  defp update_item_quality(%Item{name: @brie} = item) do
    increase_quality(item, @decay_rate)
  end

  defp update_item_quality(%Item{name: @conjured, sell_in: sell_in} = item) when sell_in <= 0 do
    decrease_quality(item, @accelerated_decay * 2)
  end

  defp update_item_quality(%Item{name: @conjured} = item) do
    decrease_quality(item, @decay_rate * 2)
  end

  defp update_item_quality(%Item{quality: quality} = item) when quality == 0 do
    item
  end

  defp update_item_quality(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    decrease_quality(item, @accelerated_decay)
  end

  defp update_item_quality(%Item{} = item) do
    decrease_quality(item, @decay_rate)
  end

  defp increase_quality(%Item{quality: quality} = item, _amount) when quality >= 50 do
    item
  end

  defp increase_quality(%Item{quality: quality} = item, amount) do
    Map.put(item, :quality, quality + amount)
  end

  defp decrease_quality(%Item{quality: quality} = item, _amount) when quality == 0 do
    item
  end

  defp decrease_quality(%Item{quality: quality} = item, amount) do
    Map.put(item, :quality, quality - amount)
  end

  defp update_item_sell_in(%Item{name: @sulfuras} = item), do: item

  defp update_item_sell_in(%Item{sell_in: sell_in} = item) do
    Map.put(item, :sell_in, sell_in - 1)
  end
end
