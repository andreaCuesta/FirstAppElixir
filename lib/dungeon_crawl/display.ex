# Protocol is a feature that lets you create a single interface that various data types # can implement, in this case hero and action

# When we create a protocol we use directive defprotocol and create functions but 
# without defining its body

# "This protocol only was created as a exercise, so it isn't use in the game"

defprotocol DungeonCrawl.Display do
    def info(value)
end


# Its necessary implement the protocol to the data types we want

defimpl DungeonCrawl.Display, for: DungeonCrawl.Room.Action do
    def info(action), do: action.label
end

defimpl DungeonCrawl.Display, for: DungeonCrawl.Character do
    def info(character), do: character.name
end


# This before was used in lib/dungeon_crawl/cli/base_commands.ex in the function 
# display_options we were list the options, like this: 
# Shell.info("#{index} - #{DungeonCrawl.Display.info(option)}")