defmodule DungeonCrawl.CLI.DifficultyLevelChoice do
    alias Mix.Shell.IO, as: Shell
    import DungeonCrawl.CLI.BaseCommands
    
    def start(rooms) do
        Shell.cmd("clear")
        Shell.info("Start by choosing the difficulty level:")
        
        levels = ["easy", "medium", "hard"]
        find_level_by_index = &Enum.at(levels, &1)
    
        display_options(levels)
        |> generate_question
        |> Shell.prompt
        |> parse_answer
        |> find_level_by_index.()
        |> set_rooms_chance(rooms, 0)
        
    end
    
    defp set_rooms_chance(_, [], _), do: []
    
    defp set_rooms_chance("easy", [ head = %DungeonCrawl.Room{type: "exit"} | tail], range_start) do
        range = range_start..range_start + 14
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
            
        [ room | set_rooms_chance("easy", tail, range_start + 15)]
    end
    defp set_rooms_chance("easy", [ head | tail], range_start) do
        range = range_start..range_start + 5
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
         [ room | set_rooms_chance("easy", tail, range_start + 6)]
    end
    
    
    defp set_rooms_chance("medium", [ head | tail], range_start) do
        range = range_start..range_start + 10
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
        
        [ room | set_rooms_chance("medium", tail, range_start + 11)]
    end
    
    
    defp set_rooms_chance("hard", [ head = %DungeonCrawl.Room{type: "exit"} | tail], range_start) do
        range = range_start..range_start + 4
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
        [ room | set_rooms_chance("hard", tail, range_start + 5)]
    end
    defp set_rooms_chance("hard", [ head = %DungeonCrawl.Room{type: "hurt"} | tail], range_start) do
        range = range_start..range_start + 15
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
        [ room | set_rooms_chance("hard", tail, range_start + 16)]
    end
    defp set_rooms_chance("hard", [ head = %DungeonCrawl.Room{type: "heal"} | tail], range_start) do
        range = range_start..range_start + 10
        room = %DungeonCrawl.Room{
            description: head.description,
            actions: head.actions,
            trigger: head.trigger,
            type: head.type,
            chance: range
            }
        [ room | set_rooms_chance("hard", tail, range_start + 11)]
    end
    
end