extends Node2D

func _ready() -> void:
    CardTracking.initialize($CardsManager)
    
    $CardsManager.cards_to_highlight.connect($CardSlotsManager.highlight_slots)