# For each type of room, we’ll build a module. Inside each module we’ll have the 
# function that knows what to do when the user chooses an action for that room. The 
# function must accept the hero and the player action as an argument and must return 
# the hero with a flag. When the flag is :exit , the game is finished; when it’s 
# :forward , the hero must keep crawling the dungeon.

defmodule DungeonCrawl.Room.Trigger do
    alias DungeonCrawl.Character
    alias DungeonCrawl.Room.Action
    
    @callback run(Character.t, Action.t) :: {Character.t, atom}
end

# @callback is a directive to tell Elixir we want to define a function rule, we have 
# a function called run. It must have two arguments; we’ll use character and action .

# Before we have -> @callback run(character :: any, action :: any) :: any
# After the argument name we have the two colons, :: , with the word any indicating 
# the arguments can be of any type. Then, after the function declaration we have the :: # again. It defines the function type return; again we’re using any.

# With this line we’re saying any module that obeys this contract must have a function
# called run that has two arguments, the first argument we expect a character type, and
# in the second we expect a room action type, and returns a tuple, where the first 
# item is a character type and the second item is an atom