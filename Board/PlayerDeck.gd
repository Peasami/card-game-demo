# Contains name of all cards in player's deck
extends Node

var mainDeck: Array = ["Firebolt", "Firebolt", "Firebolt"]

func get_card_instance(cardName: String) -> Node:
	var path: Resource = load("res://CardLibrary/"+cardName+"/"+cardName+".tscn")
	return path.instantiate()

func add_card_to_deck(cardName: String) -> void:
	mainDeck.append(cardName)
