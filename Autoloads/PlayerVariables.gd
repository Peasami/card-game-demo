# Global autoload for storing player data

extends Node

var maxHandSize := 5
var reDrawNumber := 2
var max_mana := 3

var current_player_health := 15
var current_mana := max_mana

func _ready() -> void:
    Events.player_damaged.connect(on_player_damaged)
    Events.mana_spent.connect(on_mana_spent)
    Events.turn_ended.connect(on_turn_ended)

func on_player_damaged(_source: Node, damage: int) -> void:
    current_player_health -= damage

func on_mana_spent(amount: int) -> void:
    current_mana -= amount

func on_turn_ended() -> void:
    current_mana = max_mana