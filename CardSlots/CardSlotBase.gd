class_name CardSlotBase
extends Node2D


func _on_focus_mouse_entered():
	Events.emit_signal("slot_hovered", true)

func _on_focus_mouse_exited():
	Events.emit_signal("slot_de_hovered")

