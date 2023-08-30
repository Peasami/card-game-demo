extends Node

var cardName = "Firebolt"
var dmg = 3
var target = CardEnums.card_target.SINGLE

func play_card():
	print(self, " Deals ", dmg, " damage")
