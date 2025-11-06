# This node sees all cards and assigns them into proper states
# Manages movement of cards in hand, and assigns anchorPositions for cards. 
# manages instantiating and drawing cards

class_name CardsManager
extends Node

# Signals
signal cards_to_highlight(slot_ids: Array[int])
signal card_tween_ended

@export var playerStats: Node # stats like hp and base mana
@export var playerDeck: Node # info on all cards in deck

func _ready() -> void:

	var fight_deck: DeckResource = PlayerDeck.main_deck

	# loads and instantiates cards
	for i in fight_deck.cards:
		var card: CardBase = instantiate_card(i.name)
		card.slots_to_highlight.connect(_on_cards_to_highlight)
		add_child(card)

	# Connect signal from event bus. Called whenever a card is moved within hand
	Events.card_moved_within_hand.connect(_on_card_moved_within_hand)
	Events.draw_cards_called.connect(draw_cards)
	Events.hand_reset_called.connect(_on_reset_hand_called)

func initialize_end_turn() -> void:
	EventQueue.append_event(
		func() -> void: reset_hand(5)
	)


func _on_reset_hand_called(amount: int) -> void:
	reset_hand(amount)

func start_turn() -> void:
	draw_cards(5)

func instantiate_card(card_name: String) -> CardBase:
	var card_scene: PackedScene = load("res://CardLibrary/CardScenes/" + card_name + ".tscn")
	card_scene.connect("hovered_in_hand", hovering_in_hand)
	card_scene.connect("de_hovered_in_hand", de_hovering_in_hand)
	return card_scene.instantiate()

func reset_hand(redraw_amount: int) -> void:
	discard_hand()
	draw_cards(redraw_amount)

func discard_hand() -> void:
	for card: CardBase in CardTracking.get_cards_in_hand():
		card.transition_state_to("InGraveyard")

# Called when a card is moved within hand
func _on_card_moved_within_hand() -> void:
	organize_hand()

# Called when DrawCards button is clicked
func _on_draw_card_clicked(amountToDraw: int = 1) -> void:
	draw_cards(amountToDraw)

# Draw n cards to hand
func draw_cards(amountToDraw: int = 1) -> void:
	for i in amountToDraw:
		# Checks if hand is full or deck is empty
		if CardTracking.get_cards_in_hand().size() >= playerStats.maxHandSize:
			print("Hand is full")
			return
		if CardTracking.get_cards_in_deck().size() == 0:
			reshuffle_deck()

		# Get random card from deck
		var drawnCard: CardBase = CardTracking.get_cards_in_deck()[randi() % CardTracking.get_cards_in_deck().size()]
		drawnCard.anchorZIndex = CardTracking.get_cards_in_hand().size()
		drawnCard.transition_state_to("InHand")
		organize_hand()

func reshuffle_deck() -> void:
	# Move all cards from the graveyard back to the deck
	for card: CardBase in CardTracking.get_cards_in_state(GEnums.card_state.IN_GRAVEYARD):
		card.transition_state_to("InDeck")

# Organizes cards in hand. Assigns anchorPositions to cards based on the number of cards in hand.
# Calls transition to InHand even when they are already in InHand state.
# transition_state_to() function just calls current node exit() and new node enter()
# Takes into account cards that are InMouse.
func organize_hand() -> void:
	for card: CardBase in CardTracking.get_cards_in_hand():
		card.anchorPosition = CardPositionData.get_card_position_in_hand(CardTracking.get_cards_in_hand().find(card), CardTracking.get_cards_in_hand().size())
		card.anchorRotation = CardPositionData.get_card_hand_rotation(card.anchorPosition.x)
		card.transition_state_to("InHand")

# Called when a card is hovered. Informs other CardBases to dodge
func hovering_in_hand(targetCard: CardBase) -> void:
	# Iterates through each other card, to make them move aside by changing their state
	for i: CardBase in CardTracking.get_cards_in_hand():
		if i == targetCard:
			continue
		if i.position.x < targetCard.position.x:
			i.transition_state_to("InHandDodging", {"cardSide": "left"})
		else:
			i.transition_state_to("InHandDodging", {"cardSide": "right"})

# Called when a card is dehovered. Informs other CardBases to go back to anchorPositions
func de_hovering_in_hand(targetCard: CardBase) -> void:
	print("Signal to dehovering in hand")
	for i: CardBase in CardTracking.get_cards_in_state(GEnums.card_state.IN_HAND_DODGING):
		if i == targetCard:
			continue
		i.transition_state_to("InHand")

func _on_cards_to_highlight(slot_ids: Array[int]) -> void:
	emit_signal("cards_to_highlight", slot_ids)