extends Node2D
class_name EnemyBase

@export var enemy_resource: Resource

# stores slot id of the slot currently on
var on_slot_id: int


func _ready():
	
	## Connect signals
	%GridMoveComponent.moved_in_grid.connect(set_on_slot_id) # whenever move occurs
	%HealthComponent.died.connect(_on_death)
	
	# Sub to signal that triggers whenever card is dealing damage
	Events.damage_triggered.connect(check_damage_event)
	
	%HealthComponent.health_changed.connect(%EnemyGraphics.set_health_ui)

	# Set sprite
	%EnemySprite.texture = enemy_resource.sprite
	
	# Set health
	%HealthComponent.set_current_health(enemy_resource.max_health)

func _on_death():
	queue_free()

# called when a signal is received from a move component
func set_on_slot_id(slot_id):
	on_slot_id = slot_id
	Events.emit_signal('enemy_moved_in_grid', self, slot_id)

# check if on damaged slot when attack is signaled
func check_damage_event(source: Node, target_slots: Array[int], amount: int):
	if on_slot_id in target_slots:
		%HealthComponent.take_damage(amount)

func move_enemy(target_slot: int):
	$GridMoveComponent.move(self, target_slot)

# TODO remove this
# debugging
func _input(event):
	if event.is_action_released("ui_left"):
		%GridMoveComponent.move_left(self)
