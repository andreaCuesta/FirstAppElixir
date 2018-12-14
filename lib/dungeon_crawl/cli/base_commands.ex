# This is a reusable module that will allow for hero and action listing and choice

defmodule DungeonCrawl.CLI.BaseCommands do
    alias Mix.Shell.IO, as: Shell
    
    def display_options(options) do
        options
        |> Enum.with_index(1)
        |> Enum.each(fn {option, index} ->
        Shell.info("#{index} - #{option}")
        end)
        options
    end
    
    def generate_question(options) do
        options = Enum.join(1..Enum.count(options), ",")
        "Which one? [#{options}]\n"
    end
    
    def parse_answer!(answer) do
        case Integer.parse(answer) do
            :error ->
                raise DungeonCrawl.CLI.InvalidOptionError
            {option, _} ->
                option - 1
        end    
    end
    
    def find_option_by_index!(index, options) do
        Enum.at(options, index)
            || raise DungeonCrawl.CLI.InvalidOptionError
    end
    
    def ask_for_option(options) do
        try do
            options
            |> display_options
            |> generate_question
            |> Shell.prompt
            |> parse_answer!
            |> find_option_by_index!(options)
        rescue
            e in DungeonCrawl.CLI.InvalidOptionError ->
            display_error(e)
            ask_for_option(options)
        end
    end
    
    def display_error(e) do
        Shell.cmd("clear")
        Shell.error(e.message)
        Shell.prompt("Press Enter to continue.")
        Shell.cmd("clear")
    end
end

# Explanation of the functions, the examples are based on hero_choice
# display_options function
# We used the Enum.with_index function to generate a list of tuples that contain the 
# heroes  and their corresponding index numbers (this start with 1):
# [{hero1, 1}, {hero2, 2}, {hero3", 3}]
# Later through Enum.each we print the index with its corresponding option; remember in # that here option is a struct, so for printing -> Shell.info("#{index} - #{option}") 
# the implementation of String.Chars in the struct model is used.

# generate_question function
# options = "1,2,3" (result of apply Enum.join)

# parse_answer! function
# It tries to parse an integer from the user input, then subtracts one to get the index # of the hero

# find_option_by_index! function
# It get the corresponding option according to the index. If Enum.at(options, index) 
# returns a falsy value it raise DungeonCrawl.CLI.InvalidOptionError. Remember that nil
# is a falsy value

# "raise" -> is used in parse_answer! and find_option_by_index!, and it expects an
# exception structure. When raise is called, it stops the function’s execution. If no
# rescue is used, the program stops showing the stack trace.

# ask_for_option function
# use different functions that helps it to ask the user for an option, between many 
# posibilities and manage the answer, at the end return the option selected. 
# In the try code block, we created the happy path of the pipeline of functions. In the
# rescue block we matched DungeonCrawl.CLI.InvalidOptionError and put the struct in a
# variable e . We used the display_error/1 function to show the error message. We also
# forced the user to try again, making a recursive call.


