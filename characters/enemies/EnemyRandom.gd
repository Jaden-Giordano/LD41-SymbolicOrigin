extends "res://characters/Entity.gd"

export var timerMovement = true

func _ready():
	movedir = rand()

func _physics_process(delta):
	if is_on_wall():
		movedir = rand()

func _on_MoveTimer_timeout():
	if timerMovement:
		movedir = rand()
	pass # replace with function body
