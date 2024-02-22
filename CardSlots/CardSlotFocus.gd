extends Node

func _on_mouse_entered():
	Events.emit_signal("slot_hovered", true)

func _on_mouse_exited():
	Events.emit_signal("slot_de_hovered")
