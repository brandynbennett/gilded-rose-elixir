defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  alias GildedRose.Item

  test "interface specification" do
    gilded_rose = GildedRose.new()
    [%Item{} | _] = GildedRose.items(gilded_rose)
    assert :ok == GildedRose.update_quality(gilded_rose)
  end

  # First test all existing functionality so I don't break anything "even bugs"

  test "initalizes with correct inventory" do
    gilded_rose = GildedRose.new()

    [
      vest,
      brie,
      mongoose,
      sulfuras,
      backstage,
      conjured
    ] = GildedRose.items(gilded_rose)

    %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20} = vest
    %Item{name: "Aged Brie", sell_in: 2, quality: 0} = brie
    %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7} = mongoose
    %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80} = sulfuras
    %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20} = backstage
    %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6} = conjured
  end

  test "update_quality sell_in decreases by 1" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [
      vest,
      brie,
      mongoose,
      sulfuras,
      backstage,
      conjured
    ] = GildedRose.items(gilded_rose)

    %Item{name: "+5 Dexterity Vest", sell_in: 9} = vest
    %Item{name: "Aged Brie", sell_in: 1} = brie
    %Item{name: "Elixir of the Mongoose", sell_in: 4} = mongoose
    %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0} = sulfuras
    %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 14} = backstage
    %Item{name: "Conjured Mana Cake", sell_in: 2} = conjured
  end
end
