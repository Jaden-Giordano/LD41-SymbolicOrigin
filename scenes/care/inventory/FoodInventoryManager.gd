extends Node

signal _close_feed_menu

func _ready():
	connect("_close_feed_menu", get_parent(), "_close_feed_inventory")

func _on_close_feed_menu():
	emit_signal("_close_feed_menu")
