extends Node

signal _continued

func _ready():
    connect("_continued", get_parent(), "_menu_continued")

func _on_continue():
    emit_signal("_continued")
