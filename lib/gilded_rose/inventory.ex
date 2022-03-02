defmodule GildedRose.Inventory do
  defstruct items: []

  def new(items) do
    %__MODULE__{items: items}
  end
end
