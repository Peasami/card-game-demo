extends Node

signal health_changed(new_health: int)
signal died

@export var max_health: int

var current_health: int = max_health

# Take damage and set health
func take_damage(damage: int):
	if damage < 1:
		pass
	set_current_health(current_health - damage)

func heal_damage(heal: int):
	if heal < 1:
		pass
	set_current_health(current_health + heal)

# send death signal to parent
func check_if_dead():
	if current_health <= 0:
		died.emit()

# Set health and emit new health to parent
func set_current_health(health: int):
	current_health = health
	health_changed.emit(current_health)
	check_if_dead()
