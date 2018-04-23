extends AnimationPlayer

export var remove = false

func _process(delta):
	if remove:
		self.remove
		print("nothing")
