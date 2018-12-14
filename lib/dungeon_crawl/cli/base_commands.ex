# This is a reusable module that will allow for hero and action listing and choice

defmodule DungeonCrawl.CLI.BaseCommands do
    use Monad.Operators
    
    alias Mix.Shell.IO, as: Shell
    import Monad.Result, only: [success: 1, success?: 1, error: 1, return: 1]
    
    def display_options(options) do
        options
        |> Enum.with_index(1)
        |> Enum.each(fn {option, index} ->
        Shell.info("#{index} - #{option}")
        end)
        return(options)
    end
    
    def generate_question(options) do
        options = Enum.join(1..Enum.count(options), ",")
        "Which one? [#{options}]\n"
    end
    
    def parse_answer(answer) do
        case Integer.parse(answer) do
            :error -> error("Invalid option")
            {option, _} -> success(option - 1)
        end
    end
    
    def find_option_by_index(index, options) do
        case Enum.at(options, index) do
            nil -> error("Invalid option")
            chosen_option -> success(chosen_option)
        end
    end
    
    def ask_for_option(options) do
        result =
            return(options)
            ~>> (&display_options/1)
            ~>> (&generate_question/1)
            ~>> (&Shell.prompt/1)
            ~>> (&parse_answer/1)
            ~>> (&(find_option_by_index(&1, options)))
        
        if success?(result) do
            result.value
        else
            display_error(result.error)
            ask_for_option(options)
        end
    end
    
    def display_error(message) do
        Shell.cmd("clear")
        Shell.error(message)
        Shell.prompt("Press Enter to continue")
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
# "We use the function return"-> to wrap the list of options in a success result.
# That’s necessary because in this library lists are a type of monad. If we pass a list
# to the bind operator, it will try to extract the items of the list. We don’t want an
# extraction in this case. That’s why we wrap the list in a result monad.

# generate_question function
# options = "1,2,3" (result of apply Enum.join); this function resturns a string, Using # this library, it’s optional to wrap a string value in a result monad. The bind
# function doesn’t try to extract values that aren’t monads.

# parse_answer function
# It tries to parse an integer from the user input, then subtracts one to get the index # of the element. As integer parsing can result in an error, we check it using case
# with pattern matching. When the parsed result is an error, we use error/1 to return
# an error result with a message. When the parsed result is a valid number, we use
# success/1 to return a success result wrapping the number.

# "Monad.Result" -> Error monad; some functions were imported from it:
# * success/1 , which wraps the given value in a result monad marked with success.
# * return/1 , which wraps the given value in a result monad marked with success.
# * error/1 , which wraps the given message in a result monad marked with failure.
# * success?/1 , which returns true when the given result monad is marked with success; 
# otherwise it returns false.
# success/1 and return/1 do the same thing. We have two names because sometimes it’s
# more favorable semantically to use one over another.

# find_option_by_index function
# It get the corresponding option according to the index. If Enum.at(options, index) 
# returns a falsy value it throw @invalid_option. Remember that nil is a falsy value.
# When Enum.at(options, index) matches a nil value we return an error result; when it
# matches a number we return a success result.

# ask_for_option function
# * use different functions that helps it to ask the user for an option, between many 
# posibilities and manage the answer, at the end return the option selected. 
# * We start the pipeline using the return/1 function to wrap the options list in a
# result monad. We need to do that because lists are monads and will trigger a
# different action in the bind operator. We use ~>> , the bind operator, to pipeline
# the functions. It works in a very similar way to our old friend the pipe operator, |>
# The main difference here is that the right side of the ~>> expects an anonymous
# function. The ~>> will decide automatically whether it should execute the next
# function. If the value is marked with an error, ~>> skips the next function; if the 
# value is marked with a success, ~>> will execute the next function.
# * We put the returning value of the pipeline execution in the result variable. We
# check if the result is a success with the success?/1 function. If it returns true we
# return the chosen option, accessing the value attribute. If it returns false we
# display the error and ask the user to try again.


