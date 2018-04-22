extends Node

var items = []

func add_item(type):
	items.append(type)

func remove_item(type):
	items.erase(type)
