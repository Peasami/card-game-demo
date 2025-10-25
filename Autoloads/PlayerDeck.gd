# Contains name of all cards in player's deck
extends Node

var starting_deck: DeckResource
var main_deck: DeckResource

func initialize(selected_deck: DeckResource) -> void:
    starting_deck = selected_deck
    main_deck = starting_deck


func add_card_to_deck(card_to_add: CardBase) -> void:
    main_deck.append(card_to_add)
