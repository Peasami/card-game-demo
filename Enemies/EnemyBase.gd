extends Node2D
class_name EnemyBase

@export var enemy_resource: Resource

# stores slot id of the slot currently on
var on_slot_id: int

func _ready() -> void:
	
	## Connect signals
	%GridMoveComponent.moved_in_grid.connect(set_on_slot_id) # whenever move occurs
	%HealthComponent.died.connect(_on_death)
	
	# Sub to signal that triggers whenever card is dealing damage
	Events.damage_triggered.connect(check_damage_event)
	Events.enemies_move_called.connect(move_enemy_direction)
	
	%HealthComponent.health_changed.connect(%EnemyGraphics.set_health_ui)

	# Set sprite
	%EnemySprite.texture = enemy_resource.sprite
	%EnemySprite.flip_h = true
	
	# Set health
	%HealthComponent.set_current_health(enemy_resource.max_health)

func _on_death() -> void:
	queue_free()

# called when a signal is received from a move component
func set_on_slot_id(slot_id: int) -> void:
	on_slot_id = slot_id
	Events.emit_signal('enemy_moved_in_grid', self, slot_id)

# check if on damaged slot when attack is signaled
func check_damage_event(_source: Node, target_slots: Array[int], amount: int) -> void:
	if on_slot_id in target_slots:
		%HealthComponent.take_damage(amount)

func move_enemy_to(target_slot: int) -> void:
	$GridMoveComponent.move(self, target_slot)

func move_enemy_direction(direction: GEnums.DIR) -> void:
	$GridMoveComponent.move_direction(direction, self)

# TODO remove this
# debugging
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_left"):
		%GridMoveComponent.move_left(self)
