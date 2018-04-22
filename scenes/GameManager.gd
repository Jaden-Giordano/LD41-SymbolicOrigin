extends Node

export(String) var menu_scene
export(String) var care_scene
export(String) var dungeon_scene

export(String) var food_inventory_scene
var food_inv_scene_loaded
onready var foods = [0, 1, 1, 0, 2, 3, 1]

onready var stats = get_node("Stats")

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
	for i in range(9):
		food_inv.get_node("Slots/" + String(i)).disabled = true

	for i in range(foods.size()):
		var item = food_inv.get_node("Slots/" + String(i))
		item.set_text(String(foods[i]))
		item.disabled = false
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