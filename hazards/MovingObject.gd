extends PathFollow2D

export var followSpeed = 1

func _physics_process(delta):
	set_offset(get_offset()+followSpeed)

