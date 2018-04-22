extends Node

export(String) var menu_scene
export(String) var care_scene
export(String) var dungeon_scene

export(String) var food_inventory_scene
var food_inv_scene_loaded

export(Texture) var simple_food
export(Texture) var nutritious_food
export(Texture) var vitamin_food
export(Texture) var protein_food

onready var stats = get_node("Stats")
onready var inventory = get_node("Inventory")

onready var food_icons = [simple_food, nutritious_food, vitamin_food, protein_food]
var food_costs = [10, 50, 50, 50]

func _input(event):
	if event is InputEventAction:
		if event.pressed and event.action == "ui_cancel":
			_exit_dungeon()

func _ready():
	food_inv_scene_loaded = load(food_inventory_scene)
	add_child(load(menu_scene).instance())

# Care
func _enter_dungeon():
	remove_child(get_node("CareFacility"))
	add_child(load(dungeon_scene).instance())

func _open_food_inventory():
	# Load food inventory scene
	var food_inv = food_inv_scene_loaded.instance()
	for i in range(4):
		var item = food_inv.get_node("Slots/" + String(i))
		item.icon = food_icons[i]
		item.set_text(String(food_costs[i]))
		
	add_child(food_inv)

func _close_feed_inventory():
	remove_child(get_node("FoodInventory"))

# Dungeon
func _exit_dungeon():
	remove_child(get_node("Dungeon"))
	add_child(load(care_scene).instance())

# Menu
func _menu_play():
	remove_child(get_node("MainMenu"))
	add_child(load(care_scene).instance())

func _menu_settings():
	pass

func _menu_quit():
	get_tree().quit()

# Universal
func _on_force_out_dungeon():
	if get_node("Dungeon") != null:
		_exit_dungeon()

func _feed(type):
	stats.eat_food(type)