extends Node

var enemy_base: PackedScene = preload("res://Enemies/EnemyBase.tscn")

func _init() -> void:
	Events.grid_created.connect(_on_grid_created)

func _on_grid_created() -> void:
	var enemy_instance: EnemyBase = enemy_base.instantiate()
	add_child(enemy_instance)
	enemy_instance.move_enemy_to(7)
	var enemy_instance2: EnemyBase = enemy_base.instantiate()
	add_child(enemy_instance2)
	enemy_instance2.move_enemy_to(23)
	var enemy_instance3: EnemyBase = enemy_base.instantiate()
	add_child(enemy_instance3)
	enemy_instance3.move_enemy_to(31)
