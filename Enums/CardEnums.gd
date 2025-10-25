# Stores possible values for card functions

class_name CardEnums
extends Node

enum card_target{
	SINGLE,
	SINGLE_ENEMY,
	SINGLE_ALLY,
	AOE_ENEMY,
	AOE_ALLY,
	AOE,
}

const aoe_target_types := [
	card_target.AOE_ENEMY,
	card_target.AOE_ALLY,
	card_target.AOE,
]

const single_target_types := [
	card_target.SINGLE,
	card_target.SINGLE_ENEMY,
	card_target.SINGLE_ALLY,
]