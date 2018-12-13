# DungeonCrawl.CLI.Main will orchestrate the game

defmodule DungeonCrawl.CLI.Main do
    alias Mix.Shell.IO, as: Shell
    
    def start_game do
        welcome_message()
        Shell.prompt("Press Enter to continue")
        
        crawl(difficulty_level_choice(), hero_choice())
    end
    
    defp welcome_message do
        Shell.info("== Dungeon Crawl ===")
        Shell.info("You awake in a dungeon full of monsters.")
        Shell.info("You need to survive and find the exit.")
    end
    
    defp hero_choice do
        hero = DungeonCrawl.CLI.HeroChoice.start()
        %{hero | name: "You"}
    end
    
    defp difficulty_level_choice do
        DungeonCrawl.Room.all()
        |> DungeonCrawl.CLI.DifficultyLevelChoice.start
    end
    
    
    defp crawl(_, %{hit_points: 0}) do
        Shell.prompt("")
        Shell.cmd("clear")
        Shell.info("Unfortunately your wounds are too many to keep walking.")
        Shell.info("You fall onto the floor without strength to carry on.")
        Shell.info("Game over!")
        Shell.prompt("")
    end
    
    defp crawl(rooms, character) do
        Shell.info("You keep moving forward to the next room.")
        Shell.prompt("Press Enter to continue")
        Shell.cmd("clear")
        
        Shell.info(DungeonCrawl.Character.current_stats(character))
        
        rooms
        |> random_room
        |> DungeonCrawl.CLI.RoomActionsChoice.start
        |> trigger_action(character)
        |> handle_action_result(rooms)
    end
    
    defp random_room(rooms) do
        last_room = Enum.at(rooms, Enum.count(rooms) - 2)
        _..last = last_room.chance
        rand = Enum.random(0..last)
        Enum.find(rooms, fn room -> Enum.member?(room.chance, rand) end)
    end
    
    defp trigger_action({room, action}, character) do
        Shell.cmd("clear")
        room.trigger.run(character, action)
    end
    
    defp handle_action_result({_, :exit}, _),
        do: Shell.info("You found the exit. You won the game. Congratulations!")
    defp handle_action_result({character, _}, rooms),
        do: crawl(rooms, character)
end


# Mix.Shell.IO brings useful functions to interact with the terminal
# For example, it has the yes?/1 function to get a positive or negative answer from the player.
# We used info to print messages with the alias Shell

# For this could be run, we have to invoke the start_game/0 function from the Mix task # in the run/1 function present in lib/mix/tasks/start.ex

# The crawl/2 function clause, which shows a “game over” message and ends the game when
# the character reaches zero hit points

# The crawl/2 function expects a character and a list of rooms. Display the hero’s
# current hit points before the player chooses an action. It takes a random room from 
# the list and starts the action-selection interaction

# The trigger_action/2 is very simple: it clears the screen and invokes the function
# run/2 from the module that is stored in trigger attribute.

# The handle_action_result/2 function, when it matches the :exit flag, will finish the
# game. Otherwise it starts a recursive call to crawl/2 , passing the hero and the 
# rooms.