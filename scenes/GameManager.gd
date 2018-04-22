extends Node

export(String) var menu_scene
export(String) var care_scene
export(String) var dungeon_scene

func _ready():
	add_child(load(menu_scene).instance())

func _enter_dungeon():
	print(dungeon_scene)
	remove_child(get_node("CareFacility"))
	add_child(load(dungeon_scene).instance())

func _menu_play():
	remove_child(get_node("MainMenu"))
	add_child(load(care_scene).instance())

func _menu_settings():
	pass

func _menu_quit():
	get_tree().quit()