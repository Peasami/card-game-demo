class_name SelectDeckButton
extends Button

signal deck_selected(deck: DeckResource)
var deck: DeckResource

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	emit_signal("deck_selected", deck)