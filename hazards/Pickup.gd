extends Node2D

export(float) var health = 0
export(float) var hunger = 0
export(int) var speed = 0
export(int) var strength = 0
export(int) var coins = 0

func _on_body_enter(body):
    if body.get_name() == "Player":
        body.pickup(health, hunger, speed, strength, coins)
        get_parent().remove_child(self)
