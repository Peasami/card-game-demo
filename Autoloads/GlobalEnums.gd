extends Node
class_name Enums

enum DIR {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

enum slot_state{
	EMPTY,
	ENEMY,
	ALLY
}

enum damage_type{
	NORMAL,
	HEAL
}

enum card_slot_type{
	ALLY,
	ENEMY
}

enum card_state{
	NO_STATE,
	IN_HAND,
	IN_HAND_DODGING,
	IN_HAND_HOVERING,
	IN_DECK,
	IN_MOUSE,
	IN_MOUSE_TARGETING,
	IN_GRAVEYARD,
}