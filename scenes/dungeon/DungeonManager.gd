extends Node2D

signal _exit_dungeon

export(String) var boss_room_path
export(PoolStringArray) var treasure_paths
export(PoolStringArray) var paths

const DUNGEON_SIZE = 100
const MAP_POS_OFFSET = 5000

onready var rooms_grid = []
onready var loaded_scenes = []
onready var current_room = Vector2(0, 0)
var room_count = 0

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
		room_count += 1
	
	return true

func load_treasure(position):
	if position.x > DUNGEON_SIZE / 2 || position.x < -DUNGEON_SIZE / 2:
		return false
	elif position.y > DUNGEON_SIZE / 2 || position.y < -DUNGEON_SIZE / 2:
		return false

	var room = rooms_grid[position.x][position.y]
	
	if room == null:
		room = load(treasure_paths[randi() % treasure_paths.size()]).instance()
		room.position = position * MAP_POS_OFFSET
		rooms_grid[position.x][position.y] = room
		add_child(room)
		room_count += 1
	
	return true

func load_boss(position):
	if position.x > DUNGEON_SIZE / 2 || position.x < -DUNGEON_SIZE / 2:
		return false
	elif position.y > DUNGEON_SIZE / 2 || position.y < -DUNGEON_SIZE / 2:
		return false

	var room = rooms_grid[position.x][position.y]
	
	if room == null:
		room = load(boss_room_path).instance()
		room.position = position * MAP_POS_OFFSET
		rooms_grid[position.x][position.y] = room
		add_child(room)
		room_count += 1
	
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

		if room_count == 3 or room_count == 6:
			if load_treasure(current_room):
				get_node("Camera2D").position = current_room * MAP_POS_OFFSET
				get_node("Player").position = (current_room * MAP_POS_OFFSET) + (-dir * Vector2(0.5, 0.375) * 325)
		elif room_count == 9:
			if load_boss(current_room):
				get_node("Camera2D").position = current_room * MAP_POS_OFFSET
				get_node("Player").position = (current_room * MAP_POS_OFFSET) + (-dir * Vector2(0.5, 0.375) * 325)
		else:
			if load_room(current_room, (randi() % (paths.size() - 1)) + 1):
				get_node("Camera2D").position = current_room * MAP_POS_OFFSET
				get_node("Player").position = (current_room * MAP_POS_OFFSET) + (-dir * Vector2(0.5, 0.375) * 325)

func _on_exit_dungeon_pressed():
	emit_signal("_exit_dungeon")
