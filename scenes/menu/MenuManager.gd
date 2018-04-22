extends Node

signal _play_pressed
signal _settings_pressed
signal _quit_pressed

func _ready():
	connect("_play_pressed", get_parent(), "_menu_play")
	connect("_settings_pressed", get_parent(), "_menu_settings")
	connect("_quit_pressed", get_parent(), "_menu_quit")

func _button_pressed(button):
	if (button == 0): emit_signal("_play_pressed")
	elif (button == 1): emit_signal("_settings_pressed")
	else: emit_signal("_quit_pressed")
