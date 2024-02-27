extends Node2D

@export var health_ui: Label

func set_health_ui(health: int) -> void:
	health_ui.text = str(health)
