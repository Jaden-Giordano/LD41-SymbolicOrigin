extends Node2D

signal _exit_dungeon

export(PoolStringArray) var paths

const DUNGEON_SIZE = 100
const MAP_POS_OFFSET = 5000

onready var rooms_grid = []
onready var loaded_scenes = []
onready var current_room = Vector2(0, 0)

func load_room(position, scene):
	if position.x > DUNGEON_SIZE / 2 || position.x < -DUNGEON_SIZE / 2:
		return false
	elif position.y > DUNGEON_SIZE / 2 || position.y < -DUNGEON_SIZE / 2:
		return false

	var room = rooms_grid[position.x][position.y]

	if room == null:
		room = loaded_scenes[scene].instance()
		room.position = position * MAP_POS_OFFSET
		rooms_grid[position.x][position.y] = room
		add_child(room)
	
	return true


func _ready():
	connect("_exit_dungeon", get_parent(), "_exit_dungeon")

	# Create an empty grid for the rooms.
	for i in range(DUNGEON_SIZE + 1): # 101 (-50 to 50)
		rooms_grid.append([])
		for j in range(DUNGEON_SIZE + 1): # 101 (-50 to 50)
			rooms_grid[i].append(null)

	# Load in the paths
	for path in paths:
		loaded_scenes.append(load(path))
	
	load_room(Vector2(0, 0), 0)


func _door_entered(direction):
	if paths.size() > 1:
		var dir = Vector2(0, 0)

		match direction:
			0: dir = Vector2(-1, 0)
			1: dir = Vector2(0, -1)
			2: dir = Vector2(1, 0)
			3: dir = Vector2(0, 1)

		current_room += dir


		if load_room(current_room, (randi() % (paths.size() - 1)) + 1):
			get_node("Camera2D").position = current_room * MAP_POS_OFFSET
			get_node("Player").position = (current_room * MAP_POS_OFFSET) + (-dir * Vector2(0.5, 0.375) * 325)

func _on_exit_dungeon_pressed():
	emit_signal("_exit_dungeon")
