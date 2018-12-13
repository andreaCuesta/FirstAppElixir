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
    
    def parse_answer(answer) do
        {option, _} = Integer.parse(answer)
        option - 1
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

# parse_answer function
# It tries to parse an integer from the user input, then subtracts one to get the index # of the hero

