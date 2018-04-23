extends Node2D

export var remove = false

func _process(delta):
	if remove:
		get_parent().remove_child(self)
