defmodule Mix.Tasks.Start do
    use Mix.Task
    
    def run(_), do: IO.puts DungeonCrawl.CLI.Main.start_game
    
end

# With "use Mix.Task" we’re turning the module into a Mix task
# We needed to put the name of our module in the namespace Mix.Tasks and create a run 
# function that must accept one argument. That argument will be the parameters the user # can pass when running a command. 

# Run: mix start
# Result: == Dungeon Crawl ===
#         You awake in a dungeon full of monsters.
#         You need to survive and find the exit.   
# "It can be run from project file, is not necessary go to the location of the file"