# Global autoload for storing player data

extends Node

var maxHandSize := 5
var reDrawNumber := 2

var current_player_health := 15

func _ready() -> void:
    Events.player_damaged.connect(on_player_damaged)

func on_player_damaged(_source: Node, damage: int) -> void:
    current_player_health -= damage