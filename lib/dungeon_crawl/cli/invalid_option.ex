defmodule DungeonCrawl.CLI.InvalidOptionError do
    defexception message: "Invalid option"
end

# defexception -> create an exception struct
# We provided a default error message using the option message: "Invalid option"