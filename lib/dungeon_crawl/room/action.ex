defmodule DungeonCrawl.Room.Action do
    alias DungeonCrawl.Room.Action
    
    defstruct label: nil, id: nil
    
    # helper functions
    def forward, do: %Action{id: :forward, label: "Move forward."}
    def rest, do: %Action{id: :rest, label: "Take a better look and rest."}
    def search, do: %Action{id: :search, label: "Search the room."}

    # Implement protocol String.Chars in the module
    defimpl String.Chars do
        def to_string(action), do: action.label
    end
    
    @type t :: %Action{id: atom, label: String.t}
end


# Before in the file lib/dungeon_crawl/cli/base_commands.ex in the function 
# display_options we were list the options using 
# Shell.info("#{index} - #{DungeonCrawl.Display.info(option)}"),  
# DungeonCrawl.Display was a protocol that we created, which had a function called 
# info, which returned the label attribute of the struct; write 
# DungeonCrawl.Display.info(option) was very verbose, so was better implement Elixir's
# protocol -> String.Chars; look lib/dungeon_crawl/cli/base_commands.ex