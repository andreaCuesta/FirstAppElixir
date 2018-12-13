defmodule DungeonCrawl.Room.Triggers.Trap do
    alias DungeonCrawl.Room.Action
    alias Mix.Shell.IO, as: Shell
    
    @behaviour DungeonCrawl.Room.Trigger
    
    def run(character, %Action{id: :forward}) do
        Shell.info("You're walking cautiously and can see the next room.")
        {character, :forward}
    end
    
    def run(character, %Action{id: :search}) do
        damage = 3
        Shell.info("You search the room looking for something useful.")
        Shell.info("You step on a false floor and fall into a trap.")
        Shell.info("You are hit by an arrow, losing #{damage} hit points.")
        {
        DungeonCrawl.Character.take_damage(character, damage),
        :forward
        }
    end
end

# if the player tries to search the room, she’ll fall into a trap. When the clause 
# matches, the :search action will make the hero lose hit points. We use
# DungeonCrawl.Character.take_damage/2 to reduce the hero’s health