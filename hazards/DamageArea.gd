extends Node2D

export(float) var damage_per_second = 2.5

var current_body = null
var tick_timer = 1

func _process(delta):
    if current_body != null:
        tick_timer += delta
        if tick_timer >= 1:
            tick_timer = 0
            current_body.damage(damage_per_second, null, null)

func _on_enter(body):
    if body.get_name() == "Player":
        current_body = body

func _on_exit(body):
    if body.get_name() == "Player":
        current_body = null
        tick_timer = 1
