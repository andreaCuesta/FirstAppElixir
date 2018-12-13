defmodule DungeonCrawl do
  @moduledoc """
  Documentation for DungeonCrawl.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DungeonCrawl.hello()
      :world

  """
  def hello do
    :world
  end
end

# Thanks to the doctest directive (present in test/dungeon_crawl_test.exs), the second # test that Elixir runs is to take the example of the documentation and see if that 
# code works as expected.

# @moduledoc -> module's documentation
# @doc -> provides documentation for the function or macro that follows the attribute.