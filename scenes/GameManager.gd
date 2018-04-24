extends Node

export(String) var start_scene
export(String) var menu_scene
export(String) var care_scene
export(String) var dungeon_scene
export(String) var settings_scene
export(String) var pause_scene
export(String) var end_scene

export(String) var food_inventory_scene
var food_inv_scene_loaded

export(Texture) var simple_food
export(Texture) var nutritious_food
export(Texture) var vitamin_food
export(Texture) var protein_food

onready var stats = get_node("Stats")
onready var inventory = get_node("Inventory")

onready var food_icons = [simple_food, nutritious_food, vitamin_food, protein_food]
var food_costs = [20, 25, 30, 35]
var can_buy = true
var inv_open = false

var pause_open = false

var playing = false

func _ready():
	food_inv_scene_loaded = load(food_inventory_scene)
	add_child(load(start_scene).instance())
	get_node("StatsView").hide()	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") && playing:
		if pause_open:
			remove_child(get_node("PauseMenu"))
			pause_open = false
		else:
			add_child(load(pause_scene).instance())
			pause_open = true

# Care
func _enter_dungeon():
	remove_child(get_node("CareFacility"))
	add_child(load(dungeon_scene).instance())
	var stats_view = get_node("StatsView")
	remove_child(stats_view)
	get_node("Dungeon/UI").add_child(stats_view)
	stats.status = 0
	get_node("DungeonMusic").play()
	get_node("PetCareMusic").stop()

func _open_food_inventory():
	if !inv_open:
		# Load food inventory scene
		var food_inv = food_inv_scene_loaded.instance()
		for i in range(4):
			var item = food_inv.get_node("Slots/" + String(i))
			if !can_buy: item.disabled = true
		add_child(food_inv)		
			
		inv_open = true

func _close_feed_inventory():
	remove_child(get_node("FoodInventory"))
	inv_open = false

func _can_buy_again():
	can_buy = true
	if inv_open:
		_close_feed_inventory()
		_open_food_inventory()

func _buy_food(type):
	if can_buy and stats.coins >= food_costs[type]:
		_feed(type)
		stats.coins -= food_costs[type]
		get_node("FoodTimer").start()
		can_buy = false
		_close_feed_inventory()
		_open_food_inventory()

func _on_training_ended(type):
	print(type)
	stats.status = 0
	if type == 0:
		stats.speed += 1
	elif type == 1:
		stats.strength += 1

func _on_speed_train():
	if stats.status == 0:
		stats.status = 1

func _on_strength_train():
	if stats.status == 0:
		stats.status = 1

# Dungeon
func _exit_dungeon():
	var stats_view = get_node("Dungeon/UI/StatsView")
	get_node("Dungeon/UI").remove_child(stats_view)
	add_child(stats_view)
	remove_child(get_node("Dungeon"))
	add_child(load(care_scene).instance())
	get_node("DungeonMusic").stop()
	get_node("PetCareMusic").play()
	stats.reset()

# Menu
func _menu_play():
	remove_child(get_node("MainMenu"))
	add_child(load(care_scene).instance())
	get_node("StatsView").show()
	get_node("DungeonMusic").stop()
	get_node("PetCareMusic").play()
	playing = true

func _menu_settings():
	if !playing:
		remove_child(get_node("MainMenu"))
	add_child(load(settings_scene).instance())

func _on_settings_close():
	remove_child(get_node("Settings"))
	if !playing:
		add_child(load(menu_scene).instance())

func _menu_quit():
	get_tree().quit()

func _menu_resume():
	remove_child(get_node("PauseMenu"))
	pause_open = false

func _menu_continued():
	remove_child(get_node("Start"))
	add_child(load(menu_scene).instance())
	get_node("DungeonMusic").play()

# Universal
func _on_force_out_dungeon():
	if get_node("Dungeon") != null:
		_exit_dungeon()

func _feed(type):
	stats.eat_food(type)

func is_playing():
	return playing

func _end_game():
	_exit_dungeon()
	get_node("StatsView").hide()
	remove_child(get_node("CareFacility"))
	add_child(load(end_scene).instance())
