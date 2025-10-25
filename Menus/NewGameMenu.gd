extends Control

func _ready() -> void:
	var starter_decks: StarterDecksResource = load("res://Deck/StarterDecks.tres")
	## For each starter deck, create a button
	for deck in starter_decks.starter_decks:
		var button: SelectDeckButton = SelectDeckButton.new()
		button.text = deck.name
		button.deck = deck
		button.connect("deck_selected", _on_deck_button_pressed)
		$StarterDecks.add_child(button)

func _on_deck_button_pressed(deck: DeckResource) -> void:
	print("Selected starter deck: " + deck.name)
	PlayerDeck.initialize(deck)
	get_tree().change_scene_to_file("res://Board/Board.tscn")
