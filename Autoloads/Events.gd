# Event bus for signaling between distant nodes
# use Events.emit_signal(signalString: String) or Events.signal.emit() to send signals
extends Node

# Signals are being used by other classes
@warning_ignore_start("unused_signal")

signal slot_hovered(slotState: int, slot_id: int)
signal slot_de_hovered

signal card_moved_within_hand

signal enemy_moved_in_grid(moving_enemy: Node2D, slot_id: int)

signal grid_created

# Sent when a card or unit deals damage
signal damage_triggered(source: Node, slot_numbers: Array[int], amount: int)

# Sent when damage is dealt to the player
signal player_damaged(source: Node, amount: int)
signal mana_spent(amount: int)

signal turn_ended

signal enemies_move_called(direction: GEnums.DIR)
signal draw_cards_called(amount: int)
signal hand_reset_called(redraw_amount: int)