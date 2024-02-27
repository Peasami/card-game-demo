# Event bus for signaling between distant nodes
# use Event.emit_signal() to send signals

extends Node

signal slot_hovered(slotState: int, slot_id: int)
signal slot_de_hovered

signal card_moved_within_hand

signal enemy_moved_in_grid(moving_enemy: Node2D, slot_id: int)

signal grid_created

signal damage_triggered(source: Node, slot_number: int, amount: int)
