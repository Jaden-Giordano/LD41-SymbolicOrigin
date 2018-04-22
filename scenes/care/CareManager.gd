extends Node

signal _enter_dungeon_pressed
signal _cuddle_triggered
signal _feed_pressed

onready var can_cuddle = true

func _ready():
	connect("_enter_dungeon_pressed", get_parent(), "_enter_dungeon")
	connect("_feed_pressed", get_parent(), "_open_food_inventory")

func _on_enter_dungeon_pressed():
	emit_signal("_enter_dungeon_pressed")

func _on_cuddle_timeout():
	can_cuddle = true

func _on_cuddle_pressed():
	if can_cuddle:
		can_cuddle = false
		emit_signal("_cuddle_triggered")
		get_node("CuddleTimer").start()
	else:
		print("Cant cuddle yet")

func _on_feed_pressed():
	emit_signal("_feed_pressed")
