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
var can_buy = true
var inv_open = false

var playing = false
	
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
	stats.status = 0
	match type:
		0: stats.speed += 1
		1: stats.strength += 1

func _on_speed_train():
	if stats.status == 0:
		stats.status = 1

func _on_strength_train():
	if stats.status == 0:
		stats.status = 1

# Dungeon
func _exit_dungeon():
	remove_child(get_node("Dungeon"))
	add_child(load(care_scene).instance())

# Menu
func _menu_play():
	remove_child(get_node("MainMenu"))
	add_child(load(care_scene).instance())
	playing = true

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

func is_playing():
	return playing