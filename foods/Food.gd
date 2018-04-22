extends Node

signal _food_pickup

export(int) var type = 0

func _ready():
	connect("_food_pickup", get_node("/root/Game"), "_on_food_pickup")

func _on_body_entered(object):
	if object.get_name() == "Player":
		emit_signal("_food_pickup", self, type)
		get_parent().remove_child(self)
	