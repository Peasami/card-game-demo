extends Node

var slotted_enemy: EnemyBase

func _init():
	Events.enemy_moved_in_grid.connect(_on_enemy_moved_in_grid)

func _on_enemy_moved_in_grid(enemy: EnemyBase, slot_id: int):
	print("working")
