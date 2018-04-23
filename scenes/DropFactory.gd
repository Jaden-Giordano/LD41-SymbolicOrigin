extends Node

export(PoolStringArray) var pickups

func create_drop(position):
    var p = randi() % (pickups.size() - 1)
    var drop = load(pickups[p]).instance()
    drop.position = position
    get_node("../Dungeon").add_child(drop)