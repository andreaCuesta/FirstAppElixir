defmodule DungeonCrawl.Room.Triggers.Rest do
    alias DungeonCrawl.Room.Action
    alias Mix.Shell.IO, as: Shell
    
    @behaviour DungeonCrawl.Room.Trigger
    
    def run(character, %Action{id: :forward}) do
        Shell.info("You're walking cautiously and can see the next room.")
        {character, :forward}
    end
    
    def run(character, %Action{id: :rest}) do
        healing = 3
        Shell.info("You search the room for a comfortable place to rest.")
        Shell.info("After a little rest you regain #{healing} hit points.")
        {
        DungeonCrawl.Character.heal(character, healing),
        :forward
        }
    end
end

# if the player tries to relax in the room, she’ll take a nap and have some hit points
# restored. When the clause matches, the rest action will make the hero restore health with the
# heal/2 function.