# We want to list all available heroes for the player

defmodule DungeonCrawl.CLI.HeroChoice do
    alias Mix.Shell.IO, as: Shell
    import DungeonCrawl.CLI.BaseCommands
    
    def start do
        Shell.cmd("clear")
        Shell.info("Choose your hero:")
        
        DungeonCrawl.Heroes.all()
        |> ask_for_option
        |> confirm_hero
    end
        
    defp confirm_hero(chosen_hero) do
        Shell.cmd("clear")
        Shell.info(chosen_hero.description)
        if Shell.yes?("Confirm?"), do: chosen_hero, else: start()
    end
end

# start function
# cmd/1-> allows us to send terminal commands to our current shell
# After clearing the screen we take the list of heroes, map their names:
# ["Knight", "Wizard", "Rogue"] cuando estaba -> Enum.map(&(&1.name))
# call display_options(display names in a numbered list, starting with 1)
# call generate_question (display question)
# use Shell.prompt (awaits an input, and returns what the user has typed.)
# call parse_answer
# use anonymous function find_hero_by_index (receive the parsed answer and return the 
# hero)
# call confirm_hero

# the functions display_options, generate_question, parse_answer are in the module 
# imported, there is the explanation of each one

# confirm_hero function
# we clear the screen, display the details of the chosen hero, and ask the user to 
# confirm the choice
# we use the yes?/1 function from Mix.Shell.IO to get the user input, check if it’s a 
# positive answer, and parse it to a Boolean value. For example, when the user answers # y, it parses to true and we return the chosen hero. If the user answers n, we restart # the process by making a recursive call to the start/0 function.

# "This module have to be invoke in DungeonCrawl.CLI.Main "
