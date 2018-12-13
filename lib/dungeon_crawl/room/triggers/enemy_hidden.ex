defmodule DungeonCrawl.Room.Triggers.EnemyHidden do
    alias DungeonCrawl.Room.Action
    alias Mix.Shell.IO, as: Shell
    
    @behaviour DungeonCrawl.Room.Trigger
    
    def run(character, %Action{id: :forward}) do
        Shell.info("You're walking cautiously and can see the next room.")
        {character, :forward}
    end
    
    def run(character, %Action{id: :rest}) do
        enemy = Enum.random(DungeonCrawl.Enemies.all)
        Shell.info("You search the room for a comfortable place to rest.")
        Shell.info("Suddenly...")
        Shell.info(enemy.description)
        Shell.info("The enemy #{enemy.name} surprises you and attacks first.")
        
        {_enemy, updated_char} = DungeonCrawl.Battle.fight(enemy, character)
        
        {
        updated_char,
        :forward
        }
    end
end

# if the player tries to rest in the room, an enemy will appear and start a battle. 
# When the clause matches the rest action, it chooses a random enemy, invokes the
# fight/2 function, and makes the enemy attack first, passing the enemy in the first
# argument. That causes the enemy to attack first, making the hero always lose hit
# points and creating a challenging encounter.