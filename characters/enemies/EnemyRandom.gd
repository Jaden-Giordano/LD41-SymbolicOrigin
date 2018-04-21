extends "res://characters/entity.gd"

const SPEED = 150

var movetimer_length = 80
var movetimer = 0

func _ready():
	movedir = rand()

func _physics_process(delta):
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = rand()
		movetimer = movetimer_length
