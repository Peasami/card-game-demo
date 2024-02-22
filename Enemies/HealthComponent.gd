extends Node

signal health_changed(type: Enums.damage_type, old_health: int, new_health: int)
signal died

@export var max_health: int

var current_health = max_health

func take_damage(damage: int):
	if damage < 1:
		pass
	current_health = current_health - damage
	health_changed.emit(Enums.damage_type.NORMAL, current_health + damage, current_health)
	check_if_dead()

func heal_damage(heal: int):
	if heal < 1:
		pass
		health_changed.emit(Enums.damage_type.HEAL, current_health - heal, current_health)
	current_health = current_health + heal

func check_if_dead():
	if current_health <= 0:
		died.emit()
