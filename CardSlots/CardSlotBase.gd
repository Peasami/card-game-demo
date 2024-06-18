class_name CardSlotBase
extends Node2D

@export var card_slot_id: int
@export var card_slot_type: Enums.card_slot_type
@export var state_machine: Node

enum state {
	EMPTY,
	ENEMY,
	ALLY
}

var slotted_enemy: EnemyBase

func _init():
	Events.enemy_moved_in_grid.connect(_on_enemy_moved_in_grid)

# Check if moving enemy moved to this slot
# Save enemy to slotted_enemy
func _on_enemy_moved_in_grid(enemy: EnemyBase, slot_id: int):
	if slotted_enemy == enemy:
		slotted_enemy = null
	if card_slot_id != slot_id:
		return
	slotted_enemy = enemy

func get_state() -> String:
	return state_machine.name
