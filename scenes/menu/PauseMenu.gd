extends Node

signal _open_settings
signal _resume
signal _quit

func _ready():
    connect("_open_settings", get_parent(), "_menu_settings")
    connect("_resume", get_parent(), "_menu_resume")
    connect("_quit", get_parent(), "_menu_quit")

func _on_resume_pressed():
    emit_signal("_resume")

func _on_settings_pressed():
    emit_signal("_open_settings")

func _on_quit_pressed():
    emit_signal("_quit")
