defmodule GildedRose do
  use Agent
  alias GildedRose.Item
  alias GildedRose.Inventory

  @doc """
  Create a new GildedRose
  """
  def new() do
    inventory =
      Inventory.new([
        Item.new("+5 Dexterity Vest", 10, 20),
        Item.new("Aged Brie", 2, 0),
        Item.new("Elixir of the Mongoose", 5, 7),
        Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
        Item.new("Conjured Mana Cake", 3, 6)
      ])

    {:ok, agent} = Agent.start_link(fn -> inventory end)

    agent
  end

  @doc """
  Get list of all items
  """
  def items(agent), do: Agent.get(agent, & &1.items)

  @doc """
  Age inventory 1 day
  """
  def update_quality(agent) do
    inventory =
      Agent.get(agent, & &1)
      |> Inventory.update_quality()

    Agent.update(agent, fn _ -> inventory end)
  end

  @doc """
  Replace all the items in inventory
  """
  def update_items(agent, items) do
    Agent.update(agent, fn _ -> Inventory.new(items) end)
  end
end
