extends Node

@export var parent: Node2D

func _on_mouse_entered():
	Events.emit_signal("slot_hovered", true, parent.card_slot_id)

func _on_mouse_exited():
	Events.emit_signal("slot_de_hovered")
