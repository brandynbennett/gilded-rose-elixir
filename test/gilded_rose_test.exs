defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  alias GildedRose.Item

  @vest "+5 Dexterity Vest"
  @brie "Aged Brie"
  @mongoose "Elixir of the Mongoose"
  @sulfuras "Sulfuras, Hand of Ragnaros"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"

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

    assert %Item{name: @vest, sell_in: 10, quality: 20} = vest
    assert %Item{name: @brie, sell_in: 2, quality: 0} = brie
    assert %Item{name: @mongoose, sell_in: 5, quality: 7} = mongoose
    assert %Item{name: @sulfuras, sell_in: 0, quality: 80} = sulfuras

    assert %Item{name: @backstage, sell_in: 15, quality: 20} = backstage

    assert %Item{name: @conjured, sell_in: 3, quality: 6} = conjured
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

    assert %Item{name: @vest, sell_in: 9} = vest
    assert %Item{name: @brie, sell_in: 1} = brie
    assert %Item{name: @mongoose, sell_in: 4} = mongoose
    assert %Item{name: @backstage, sell_in: 14} = backstage
    assert %Item{name: @conjured, sell_in: 2} = conjured
  end

  test "update_quality quality decreases by 1 for normal things" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [vest, _, mongoose | _] = GildedRose.items(gilded_rose)

    assert %Item{name: @vest, quality: 19} = vest
    assert %Item{name: @mongoose, quality: 6} = mongoose
  end

  test "update_quality quality increases Brie by 1" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_quality(gilded_rose)

    [_, brie | _] = GildedRose.items(gilded_rose)

    assert %Item{name: @brie, quality: 1} = brie
  end

  test "update_quality quality increases Backstage by 1" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_items(gilded_rose, [Item.new(@backstage, 20, 0)])
    :ok = GildedRose.update_quality(gilded_rose)

    [backstage] = GildedRose.items(gilded_rose)

    assert %Item{name: @backstage, sell_in: 19, quality: 1} = backstage
  end

  test "update_quality quality is not negative" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_items(gilded_rose, [Item.new("foo", 0, 0)])
    :ok = GildedRose.update_quality(gilded_rose)

    assert [%Item{name: "foo", sell_in: -1, quality: 0}] = GildedRose.items(gilded_rose)
  end

  test "update_quality sell_in cannot be more than 50" do
    gilded_rose = GildedRose.new()
    :ok = GildedRose.update_items(gilded_rose, [Item.new(@brie, 10, 50)])
    :ok = GildedRose.update_quality(gilded_rose)

    assert [%Item{name: @brie, sell_in: 9, quality: 50}] = GildedRose.items(gilded_rose)
  end

  test "update_items can update all items in the inventory" do
    gilded_rose = GildedRose.new()
    assert :ok = GildedRose.update_items(gilded_rose, ["foo"])
    assert ["foo"] = GildedRose.items(gilded_rose)
  end
end
