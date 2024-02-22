extends Node


func _ready():
	for node in get_children():
		node.move_enemy(3)
