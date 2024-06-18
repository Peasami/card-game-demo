extends Node2D

# Takes in position of attacker
# Sends "damage" signal with attacked positions
func on_attack(enemy_base: EnemyBase, damage_amount) -> void:
	var attacked_slots: Array[int] = get_attacked_positions(enemy_base.on_slot_id)
	Events.damage_triggered.emit(enemy_base, attacked_slots, damage_amount)

# Return slots that the unit is attacking
func get_attacked_positions(attacker_slot: int) -> Array[int]:
	var attacked_slots: Array[int]
	
	var attacked_slot = attacker_slot + 4
	while attacked_slot < 16:
		if attacked_slot < 8:
			attacked_slot = attacked_slot + 4
			continue
		attacked_slots.append(attacked_slot)
		attacked_slot = attacked_slot + 4
	
	return attacked_slots
