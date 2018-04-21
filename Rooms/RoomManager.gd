extends TileMap

signal _door_trigger

func _ready():
    connect("_door_trigger", get_parent(), "_door_entered")
    pass

func _door_entered(body, direction):
    if body.get_name() == "Player":
        emit_signal("_door_trigger", direction)
        pass
    pass
