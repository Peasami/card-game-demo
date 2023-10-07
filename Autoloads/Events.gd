# Event bus for signaling between distant nodes
# use Event.emit_signal() to send signals

extends Node

signal slot_hovered(slotState: int)
signal slot_de_hovered

signal card_moved_within_hand
