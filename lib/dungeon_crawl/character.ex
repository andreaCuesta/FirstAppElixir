defmodule DungeonCrawl.Character do
    defstruct name: nil,
              description: nil,
              hit_points: 0,
              max_hit_points: 0,
              attack_description: nil,
              damage_range: nil
              
     # Implement protocol String.Chars in the module
    defimpl String.Chars do
        def to_string(character), do: character.name
    end
    
    @type t :: %DungeonCrawl.Character{
        name: String.t,
        description: String.t,
        hit_points: non_neg_integer,
        max_hit_points: non_neg_integer,
        attack_description: String.t,
        damage_range: Range.t
    }
    
    def take_damage(character, damage) do
        new_hit_points = max(0, character.hit_points - damage)
        %{character | hit_points: new_hit_points}
    end
    
    def heal(character, healing_value) do 
        new_hit_points = min(
            character.hit_points + healing_value, 
            character.max_hit_points
            )
        %{character | hit_points: new_hit_points}    
    end
    
    def current_stats(character),
        do: "Player Stats\nHP: #{character.hit_points}/#{character.max_hit_points}"
    
end

# We used the defstruct directive to create the character struct, passing a keyword 
# list. The key is the attribute name, and the value will be the default value when we
# initialize a struct.

# Atributes' meaning:
# * name —a name that differentiates one character from others
# * description —a long description that explains the character’s advantages and
# disadvantages
# * hit_points —current hit points
# * max_hit_points —the maximum hit points a character can have
# * attack_description —the text that explains how a character attacks another
# * damage_range —the minimum and maximum damage a character can cause
# when attacking

# Create character
# warrior = %DungeonCrawl.Character{name: "Warrior"}
# Result: %DungeonCrawl.Character{attack_description: nil, damage_range: nil,
# description: nil, hit_points: 0, max_hit_points: 0, name: "Warrior"}

# "IMPORTANT"
# Before in the file lib/dungeon_crawl/cli/base_commands.ex in the function 
# display_options we were listing the options using 
# Shell.info("#{index} - #{DungeonCrawl.Display.info(option)}"),  
# DungeonCrawl.Display was a protocol that we created, which had a function called 
# info, which returned the name attribute of the struct; write 
# DungeonCrawl.Display.info(option) was very verbose, so was better implement Elixir's
# protocol -> String.Chars; look lib/dungeon_crawl/cli/base_commands.ex

# "@type"
# We used the @type directive to start the type definition. That type has the name t ,
# and the code after the :: is the type definition. We’re saying the type is a 
# DungeonCrawl.Character struct, and is composed of attributes with their specified 
# types. Some types we can reference with simple names, like integer . Types like 
# String we reference by accessing the t function from their modules. It’s a common 
# convention in Elixir to define the struct type with t .

# take_damage function
# receives a character and the number of hit points that character should lose. The
# function won’t let the character have negative hit points, so it uses the function
# max to guarantee the character has at least zero hit points. We’re using the          # %{ map | key: new_value } syntax to update the values of the struct

# heal function
# receives a character and the number of hit points that character should have
# restored. We use the min/2 function to guarantee the hit points aren’t greater than
# the character’s maximum allowable hit points.

# current_stats function
# builds a message with the hero’s current hit points compared to the maximum allowable