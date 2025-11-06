extends Node2D

func _init() -> void:
	Events.turn_ended.connect(_on_turn_ended)

func _ready() -> void:
	
	CardTracking.initialize($CardsManager)
	
	$CardsManager.cards_to_highlight.connect($CardSlotsManager.highlight_slots)
	$CardsManager.start_turn()

func _on_turn_ended() -> void:
	$EnemyManager.initialize_end_turn()
	$CardsManager.initialize_end_turn()