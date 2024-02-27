extends Node

var enemy_base = preload("res://Enemies/EnemyBase.tscn")

func _init():
	Events.grid_created.connect(_on_grid_created)

func _on_grid_created():
	var enemy_instance = enemy_base.instantiate()
	add_child(enemy_instance)
	enemy_instance.move_enemy(3)
	var enemy_instance2 = enemy_base.instantiate()
	add_child(enemy_instance2)
	enemy_instance2.move_enemy(2)
