# The battle module will have functions that will make two characters fight. It doesn’t
# matter if they’re heroes or enemies; it will make each one attack the other until one
# of them reaches zero hit points

defmodule DungeonCrawl.Battle do
    alias DungeonCrawl.Character
    alias Mix.Shell.IO, as: Shell
    
    def fight(
        char_a = %{hit_points: hit_points_a},
        char_b = %{hit_points: hit_points_b})
        when hit_points_a == 0 or hit_points_b == 0, do: {char_a, char_b}
    
    def fight(char_a, char_b) do
        char_b_after_damage = attack(char_a, char_b)
        char_a_after_damage = attack(char_b_after_damage, char_a)
        fight(char_a_after_damage, char_b_after_damage)
    end
    
    defp attack(%{hit_points: hit_points_a}, character_b) 
        when hit_points_a == 0, do: character_b
    defp attack(char_a, char_b) do
        damage = Enum.random(char_a.damage_range)
        char_b_after_damage = Character.take_damage(char_b, damage)
        
        char_a
            |> attack_message(damage)
            |> Shell.info
            
        char_b_after_damage
            |> receive_message(damage)
            |> Shell.info
            
        char_b_after_damage    
    end
    
    defp attack_message(character = %{name: "You"}, damage) do
        "You attack with #{character.attack_description} " <>
        "and deal #{damage} damage."
    end
    defp attack_message(character, damage) do
        "#{character.name} attacks with " <>
        "#{character.attack_description} and " <>
        "deals #{damage} damage."
    end
    
    defp receive_message(character = %{name: "You"}, damage) do
        "You receive #{damage}. Current HP: #{character.hit_points}."
    end
    defp receive_message(character, damage) do
        "#{character.name} receives #{damage}. " <>
        "Current HP: #{character.hit_points}."
    end
end

# fight/2 function
# check if one of the characters has zero hit points. If yes, the battle is over and
# the function returns a tuple with the characters in the same order as the given
# arguments. If not, the characters will attack each other using the attack function.

# attack/2 function
# checks if the attacker has zero hit points; if so, nothing happens to the attacked
# character. If not, the attacked character receives a random amount of damage from the
# attacker’s damage range. This function also prints on the console the damage taken
# and the current character hit points with the functions attack_message and 
# receive_message

# message functions
# apply the proper grammar depending on whether the message is about the enemy or the
# player