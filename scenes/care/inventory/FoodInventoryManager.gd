extends Node

signal _close_feed_menu
signal _item_pressed

func _ready():
	connect("_close_feed_menu", get_parent(), "_close_feed_inventory")
	connect("_item_pressed", get_parent(), "_buy_food")

func _on_close_feed_menu():
	emit_signal("_close_feed_menu")

func _button_pressed(type):
	emit_signal("_item_pressed", type)
