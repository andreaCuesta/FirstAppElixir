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
        
    def ask_for_index(options) do
        answer =
            options
            |> display_options
            |> generate_question
            |> Shell.prompt
            |> Integer.parse
            
        case answer do
            :error ->
                display_invalid_option()
                ask_for_index(options)
            {option, _} ->
                option - 1
        end
    end
    
    def display_invalid_option do
        Shell.cmd("clear")
        Shell.error("Invalid option.")
        Shell.prompt("Press Enter to try again.")
        Shell.cmd("clear")
    end
    
    def ask_for_option(options) do
        index = ask_for_index(options)
        chosen_option = Enum.at(options, index)
        chosen_option
            || (display_invalid_option() && ask_for_option(options))
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

# ask_for_index function
# asks the user to input a number that will be used as an index to find the correct
# option. We use Integer.parse/1 and check with case if the user has typed a valid
# number. We display an error message with display_invalid_option/0 and make the user
# try again when the number is invalid. If the user inputs a valid number, we just
# return the number

# ask_for_option function
# Using Enum.at/2 we try to find the option with the index input by the user. It
# returns nil when it doesn’t find an existing index. Remember, the nil value is falsy.
# We return chose_option when it’s truthy. When it’s not, we use the operator || to
# display the invalid option message and ask the user to try again.

