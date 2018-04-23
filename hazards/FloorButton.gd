extends Node2D

func _on_pressed(body):
    if body.get_name() == "Player":
        get_node("Up").hide()
        get_node("Down").show()
        remove_from_group("goal")
