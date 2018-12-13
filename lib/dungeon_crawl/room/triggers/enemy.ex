# this trigger starts the battle

defmodule DungeonCrawl.Room.Triggers.Enemy do
    @behaviour DungeonCrawl.Room.Trigger
    
    alias Mix.Shell.IO, as: Shell
    
    def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
        enemy = Enum.random(DungeonCrawl.Enemies.all)
        
        Shell.info(enemy.description)
        Shell.info("The enemy #{enemy.name} wants to fight.")
        Shell.info("You were prepared and attack first.")
        {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)
        
        {updated_char, :forward}
    end
end

# run/2 function
# We take a random enemy from the list of enemies, and we invoke
# DungeonCrawl.Battle.fight/2 , passing the hero and the enemy. The function’s return
# is the updated character after the battle, and the flag forward indicates the player
# hasn’t found the exit yet