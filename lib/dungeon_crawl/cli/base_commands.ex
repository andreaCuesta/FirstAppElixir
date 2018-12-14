# This is a reusable module that will allow for hero and action listing and choice

defmodule DungeonCrawl.CLI.BaseCommands do
    alias Mix.Shell.IO, as: Shell
    
    @invalid_option {:error, "Invalid option"}
    
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
        case Integer.parse(answer) do
        :error ->
            throw @invalid_option
        {option, _} ->
            option - 1
        end
    end
    
    def find_option_by_index(index, options) do
        Enum.at(options, index) || throw @invalid_option
    end
    
    def ask_for_option(options) do
            options
            |> display_options
            |> generate_question
            |> Shell.prompt
            |> parse_answer
            |> find_option_by_index(options)
        catch
            {:error, message} ->
                display_error(message)
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

# find_option_by_index function
# It get the corresponding option according to the index. If Enum.at(options, index) 
# returns a falsy value it throw @invalid_option. Remember that nil
# is a falsy value

# "@invalid_option" -> contains an atom indicating an error, and a string with an error
# message. Then we used the function throw to stop the function execution from throwing
# the @invalid_option value when parse_answer/1 or find_option_by_index/2 results in an
# error

# ask_for_option function
# use different functions that helps it to ask the user for an option, between many 
# posibilities and manage the answer, at the end return the option selected. 
# Inside the try block(try was omitted because we only need one try) we have the happy-
# path code. In the catch block we used pattern matching to catch the values thrown.
# catch works very similarly to the case statement: each line has a pattern-matching
# expression and a code block to be executed.
