defmodule DungeonCrawl.Room.Triggers.Exit do
    @behaviour DungeonCrawl.Room.Trigger
    
    def run(character, _), do: {character, :exit}
end

# We used @behaviour directive to tell Elixir the Exit module follows the Room.Trigger 
# contract. That contract says we need to implement a run function. If we try to compile # the project without implementing a run , the compiler will complain about the missing
# function