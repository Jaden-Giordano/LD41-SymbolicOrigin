extends "res://characters/entity.gd"

const SPEED = 40

var movetimer_length = 20
var movetimer = 0

func _ready():
	movedir = rand()


func _physics_process(delta):
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = rand()
		movetimer = movetimer_length
