extends "res://characters/entity.gd"

export var speed = 50
export var timerMovement = true

func _ready():
	SPEED = speed
	movedir = rand()

func _physics_process(delta):
	if is_on_wall():
		movedir = rand()

func _on_MoveTimer_timeout():
	if timerMovement:
		movedir = rand()
	pass # replace with function body
