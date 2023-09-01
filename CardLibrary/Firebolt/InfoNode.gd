# Responsible for storing necessary card info
extends Node

var cardInfoArray := {
    "name": "Firebolt", 
    "damage": 3, 
    "target": CardEnums.card_target.SINGLE}

func get_card_info_array() -> Dictionary:
    return cardInfoArray