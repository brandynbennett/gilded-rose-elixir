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

    assert %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20} = vest
    assert %Item{name: "Aged Brie", sell_in: 2, quality: 0} = brie
    assert %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7} = mongoose
    assert %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80} = sulfuras

    assert %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20} =
             backstage

    assert %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6} = conjured
  end

  test "update_quality sell_in decreases by 1 for normal things" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [
      vest,
      brie,
      mongoose,
      _,
      backstage,
      conjured
    ] = GildedRose.items(gilded_rose)

    assert %Item{name: "+5 Dexterity Vest", sell_in: 9} = vest
    assert %Item{name: "Aged Brie", sell_in: 1} = brie
    assert %Item{name: "Elixir of the Mongoose", sell_in: 4} = mongoose
    assert %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 14} = backstage
    assert %Item{name: "Conjured Mana Cake", sell_in: 2} = conjured
  end

  test "update_quality quality decreases by 1 for normal things" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [vest, _, mongoose | _] = GildedRose.items(gilded_rose)

    assert %Item{name: "+5 Dexterity Vest", quality: 19} = vest
    assert %Item{name: "Elixir of the Mongoose", quality: 6} = mongoose
  end

  test "update_quality quality increases Brie by 1" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [_, brie | _] = GildedRose.items(gilded_rose)

    assert %Item{name: "Aged Brie", quality: 1} = brie
  end

  test "update_items can update all items in the inventory" do
    gilded_rose = GildedRose.new()
    assert :ok = GildedRose.update_items(gilded_rose, ["foo"])
    assert ["foo"] = GildedRose.items(gilded_rose)
  end
end
