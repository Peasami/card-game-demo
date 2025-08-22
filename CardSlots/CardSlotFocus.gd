extends Node

@export var parent: CardSlotBase

func _on_mouse_entered():
	Events.emit_signal("slot_hovered", parent.slot_state, parent.card_slot_id)

func _on_mouse_exited():
	Events.emit_signal("slot_de_hovered")
