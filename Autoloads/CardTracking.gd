# Tracks the position/state of cards on the board.
# For easier access to location of each card.
extends Node

var cards_manager_node: CardsManager

func initialize(cards_manager: CardsManager) -> void:
	cards_manager_node = cards_manager

func get_cards_in_deck() -> Array[CardBase]:
	var cards_in_deck: Array[CardBase]
	for card: CardBase in cards_manager_node.get_children():
		if card.get_state_enum() == GEnums.card_state.IN_DECK:
			cards_in_deck.append(card)
	return cards_in_deck

func get_cards_in_hand() -> Array[CardBase]:
	var cards_in_hand: Array[CardBase]
	for card: CardBase in cards_manager_node.get_children():
		if card.get_state_enum() == GEnums.card_state.IN_HAND:
			cards_in_hand.append(card)
	return cards_in_hand

func get_cards_in_state(state: GEnums.card_state) -> Array[CardBase]:
	var cards_in_state: Array[CardBase]
	for card: CardBase in cards_manager_node.get_children():
		if card.get_state_enum() == state:
			cards_in_state.append(card)
	return cards_in_state

## TODO: Implement caching for card states, so we don't have to search through all cards every time
## for fast lookups. Implement function to manually update cache.
