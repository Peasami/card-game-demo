extends Node

## TODO: ability to create different enemies
var enemy_base: PackedScene = preload("res://Enemies/EnemyBase.tscn")

func _init() -> void:
	Events.grid_created.connect(_on_grid_created)

func _on_grid_created() -> void:
	create_enemy(7)
	create_enemy(23)
	create_enemy(31)

## TODO: add enemy_to_create parameter
func create_enemy(initial_slot: int) -> void:
	var enemy_instance: EnemyBase = enemy_base.instantiate()
	add_child(enemy_instance)
	enemy_instance.teleport_to_slot(initial_slot)

func initialize_end_turn() -> void:
	for enemy: EnemyBase in get_children():
		enemy.initialize_end_turn()