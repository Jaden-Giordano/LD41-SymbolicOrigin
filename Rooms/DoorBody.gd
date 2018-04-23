extends Node2D

func _on_room_finished():
    get_node("Open").show()
    get_node("Closed").hide()
    get_node("StaticBody2D/CollisionShape2D").disabled = true
