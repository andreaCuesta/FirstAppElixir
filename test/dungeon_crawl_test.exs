defmodule DungeonCrawlTest do
  use ExUnit.Case
  doctest DungeonCrawl

  test "greets the world" do
    assert DungeonCrawl.hello() == :world
  end
end

# "use" permits another module to take actions and inject code on the calling module. 
# It adds new capabilities to the current module, mostly by using metaprogramming 
# features.

# With use ExUnit.Case , we’re adding the capacity to run tests and utility functions 
# for testing to our DungeonCrawlTest module.

# The directive doctest came from ExUnit.Case . It parses our module documentation, 
# runs the code inside of it, and checks if it’s working.