extends TileMap

signal _door_trigger

func _ready():
	connect("_door_trigger", get_parent(), "_door_entered")

func _door_entered(body, direction):
	if body.get_name() == "Player":
		emit_signal("_door_trigger", direction)
<<<<<<< Updated upstream
=======

func _process(delta):
	if get_tree().get_nodes_in_group("goal").size() == 0 and first:
		first = false
		emit_signal("_room_finished")
>>>>>>> Stashed changes
