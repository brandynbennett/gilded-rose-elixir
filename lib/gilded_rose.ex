defmodule GildedRose do
  use Agent
  alias GildedRose.Item
  alias GildedRose.Inventory

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

  def items(agent), do: Agent.get(agent, & &1.items)

  def update_quality(agent) do
    inventory =
      Agent.get(agent, & &1)
      |> Inventory.update_quality()

    Agent.update(agent, fn _ -> inventory end)

    # for i <- 0..(Agent.get(agent, &length/1) - 1) do
    #   item = Agent.get(agent, &Enum.at(&1, i))

    #   item =
    #     cond do
    #       item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #         if item.quality > 0 do
    #           if item.name != "Sulfuras, Hand of Ragnaros" do
    #             %{item | quality: item.quality - 1}
    #           else
    #             item
    #           end
    #         else
    #           item
    #         end

    #       true ->
    #         cond do
    #           item.quality < 50 ->
    #             item = %{item | quality: item.quality + 1}

    #             cond do
    #               item.name == "Backstage passes to a TAFKAL80ETC concert" ->
    #                 item =
    #                   cond do
    #                     item.sell_in < 11 ->
    #                       cond do
    #                         item.quality < 50 ->
    #                           %{item | quality: item.quality + 1}

    #                         true ->
    #                           item
    #                       end

    #                     true ->
    #                       item
    #                   end

    #                 cond do
    #                   item.sell_in < 6 ->
    #                     cond do
    #                       item.quality < 50 ->
    #                         %{item | quality: item.quality + 1}

    #                       true ->
    #                         item
    #                     end

    #                   true ->
    #                     item
    #                 end

    #               true ->
    #                 item
    #             end

    #           true ->
    #             item
    #         end
    #     end

    #   item =
    #     cond do
    #       item.name != "Sulfuras, Hand of Ragnaros" ->
    #         %{item | sell_in: item.sell_in - 1}

    #       true ->
    #         item
    #     end

    #   item =
    #     cond do
    #       item.sell_in < 0 ->
    #         cond do
    #           item.name != "Aged Brie" ->
    #             cond do
    #               item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #                 cond do
    #                   item.quality > 0 ->
    #                     cond do
    #                       item.name != "Sulfuras, Hand of Ragnaros" ->
    #                         %{item | quality: item.quality - 1}

    #                       true ->
    #                         item
    #                     end

    #                   true ->
    #                     item
    #                 end

    #               true ->
    #                 %{item | quality: item.quality - item.quality}
    #             end

    #           true ->
    #             cond do
    #               item.quality < 50 ->
    #                 %{item | quality: item.quality + 1}

    #               true ->
    #                 item
    #             end
    #         end

    #       true ->
    #         item
    #     end

    #   Agent.update(agent, &List.replace_at(&1, i, item))
    # end

    # :ok
  end

  @doc """
  Replace all the items in inventory
  """
  def update_items(agent, items) do
    Agent.update(agent, fn _ -> Inventory.new(items) end)
  end
end
