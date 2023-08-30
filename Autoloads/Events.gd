# Event bus for signaling between distant nodes
# use Event.emit_signal() to send signals

extends Node

signal slot_hovered(isTrue: bool)

signal card_moved_within_hand
