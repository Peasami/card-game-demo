extends Node

var cardName = "HealingTouch"
var amount = 3
var target = CardEnums.card_target.SINGLE_ALLY

func play_card(_target: Node):
	print(self, " Heals ", amount, " damage to ", target)
