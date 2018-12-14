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
    
    def ask_for_option(options) do
        answer =
            options
            |> display_options
            |> generate_question
            |> Shell.prompt
            
        with {option, _} <- Integer.parse(answer),
            chosen when chosen != nil <- Enum.at(options, option - 1) do
          chosen
        else
            :error -> retry(options)
            nil -> retry(options)
        end    
    end
    
    def retry(options) do
        display_error("Invalid option")
        ask_for_option(options)
    end
    
    def display_error(message) do
        Shell.cmd("clear")
        Shell.error(message)
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

# parse_answer function
# It tries to parse an integer from the user input, then subtracts one to get the index # of the hero

# ask_for_option function
# Use different functions that helps it to ask the user for an option, between many 
# posibilities and manage the answer, at the end return the option selected. It has 
# three parts:
# 1. we display options to the user and get an answer
# 2. we use "with" to parse and find the user’s chosen option
# 3. we use the else block of with to handle invalid answers, asking the user to try
# again with the function retry .

