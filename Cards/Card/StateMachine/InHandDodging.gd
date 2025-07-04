class_name InHandDodging
extends CardState

@export var amountToDodge: int # How far should cards other than hovered one move out of the way

func _init() -> void:
	state_name = GEnums.card_state.IN_HAND_DODGING
	super()

func enter(_msg := {}) -> void:
	## _msg has info which side should card be moving
	if _msg.has('cardSide'):
		match _msg['cardSide']:
			'left':
				tween = create_tween().set_parallel(true)
				tween.tween_property(cardBase, 'position', cardBase.anchorPosition - Vector2(amountToDodge, 0), 0.1)
				tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.2)
			'right':
				tween = create_tween().set_parallel(true)
				tween.tween_property(cardBase, 'position', cardBase.anchorPosition - Vector2(-amountToDodge, 0), 0.1)
				tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.2)
			_:
				push_error(self, ": There should be a left or right _msg here!!!")


func exit():
	tween.stop()
