extends Node

export(String) var care_scene
export(String) var dungeon_scene

func _enter_dungeon():
	remove_child(get_node("CareFacility"))
	add_child(load(dungeon_scene).instance())