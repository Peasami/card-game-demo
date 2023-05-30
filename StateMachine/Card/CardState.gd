# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name CardState
extends State

var cardBase: CardBase
@onready var tween

func _ready() -> void:
	await owner.ready
	cardBase = owner as CardBase
	assert(cardBase != null)
