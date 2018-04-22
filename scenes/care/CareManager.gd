extends Node

signal _enter_dungeon_triggered

func _enter_dungeon_clicked():
	emit_signal("_enter_dungeon_triggered")
