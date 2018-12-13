defmodule DungeonCrawl.Room do
    alias DungeonCrawl.Room
    alias DungeonCrawl.Room.Triggers
    
    import DungeonCrawl.Room.Action
    
    defstruct description: nil, actions: [], trigger: nil, type: nil, chance: nil
    
    def all, do: [
        %Room{
            description: "You can see the light of day. You found the exit!",
            actions: [forward()],
            trigger: Triggers.Exit,
            type: "exit"
        },
        %Room{
            description: "You can see an enemy blocking your path.",
            actions: [forward()],
            trigger: Triggers.Enemy,
            type: "hurt"
        },
        %Room{
            description: "You can go and take a treasure.",
            actions: [forward(), search()],
            trigger: Triggers.Treasure,
            type: "heal"
        },
        %Room{
            description: "You can see something strange.",
            actions: [forward(), search()],
            trigger: Triggers.Trap,
            type: "hurt"
        },
        %Room{
            description: "Is someone there?",
            actions: [forward(), rest()],
            trigger: Triggers.EnemyHidden,
            type: "hurt"
        },
        %Room{
            description: "Aww, is a beautiful and confortable place.",
            actions: [forward(), rest()],
            trigger: Triggers.Rest,
            type: "heal"
        },
    ]
end

# all function -> lists all available rooms
# the trigger attribute store a module that respects the Room.Trigger contract, having
# the actions’ behavior and consequences
