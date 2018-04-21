extends Node2D

export(PoolStringArray) var paths

const DUNGEON_SIZE = 100
const MAP_POS_OFFSET = 1000

onready var rooms_grid = []

onready var loaded_scenes = []

func load_room(position, scene):
    if position.x > DUNGEON_SIZE / 2 || position.x < -DUNGEON_SIZE / 2:
        return -1
    elif position.y > DUNGEON_SIZE / 2 || position.y < -DUNGEON_SIZE / 2:
        return -1
    
    var room = rooms_grid[position.x][position.y]

    if room == 0:
        room = loaded_scenes[scene].instance()
        room.position = position * MAP_POS_OFFSET
        add_child(room)
    
    return room
    

func _ready():
    # Create an empty grid for the rooms.
    for i in range(DUNGEON_SIZE + 1): # 101 (-50 to 50)
        rooms_grid.append([])
        for j in range(DUNGEON_SIZE + 1): # 101 (-50 to 50)
            rooms_grid[i].append(0)
    
    # Load in the paths
    for path in paths:
        print(path)
        print(load(path))
        loaded_scenes.append(load(path))
    
    load_room(Vector2(0, 0), 0)


func _door_entered(direction):
    print(direction);