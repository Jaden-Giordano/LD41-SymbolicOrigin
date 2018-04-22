extends Node

var foods = [0, 0, 1, 0, 2, 1, 2, 1]

func add_food(type):
	foods.append(type)

func remove_food(type):
	foods.erase(type)
