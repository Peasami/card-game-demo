class_name CardSlotBase
extends Node2D

@export var card_slot_id: int
@export var card_slot_type: Enums.card_slot_type
@export var state_machine: Node

var slot_state: GEnums.slot_state = GEnums.slot_state.EMPTY

var slotted_enemy: EnemyBase

func _init() -> void:
	Events.enemy_moved_in_grid.connect(_on_enemy_moved_in_grid)

# Check if moving enemy moved to this slot
# Save enemy to slotted_enemy
func _on_enemy_moved_in_grid(enemy: EnemyBase, new_slot_id: int, previous_slot_id: int) -> void:
	if slotted_enemy == enemy:
		slot_state = GEnums.slot_state.EMPTY
		slotted_enemy = null
	if card_slot_id != new_slot_id:
		return
	slotted_enemy = enemy
	slot_state = GEnums.slot_state.ENEMY

func get_state() -> String:
	return state_machine.name

func highlight_slot() -> void:
	modulate = Color(0.5, 1, 0.5)

func unhighlight_slot() -> void:
	modulate = Color(1, 1, 1)