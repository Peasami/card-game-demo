extends Node2D
class_name EnemyBase

@export var enemy_resource: EnemyResBase

# Signals
signal move_tween_finished

# stores slot id of the slot currently on
var on_slot_id: int

# Get and store health in health component
var current_health: int:
	get:
		return %HealthComponent.current_health
	set(value):
		%HealthComponent.set_current_health(value)

func _ready() -> void:
	
	## Connect signals
	# %GridMoveComponent.moved_in_grid.connect(set_on_slot_id) # whenever move occurs
	%GridMoveComponent.grid_move_requested.connect(_on_grid_move_requested)
	%GridMoveComponent.reached_end_of_grid.connect(_on_reached_end_of_grid) # when enemy reaches end of grid
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

## Teleport to slot without tweening
func teleport_to_slot(target_slot: int) -> void:
	%GridMoveComponent.on_slot_id = target_slot
	on_slot_id = %GridMoveComponent.on_slot_id
	position = CardSlotData.slot_id_to_vector(target_slot)


func initialize_end_turn() -> void:
	EventQueue.append_event(
		func() -> void: move_enemy_direction(GEnums.DIR.LEFT),
		move_tween_finished
	)

func _on_grid_move_requested(new_position: Vector2, new_slot_id: int) -> void:
	# Move to the new position
	# Use distance-based duration so movement speed is consistent regardless of distance.
	# Interpret movespeed as pixels-per-second. Duration = distance / speed.
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR)
	var distance: float = position.distance_to(new_position)
	var speed: float = max(1.0, float(%GridMoveComponent.movespeed))
	var duration: float = distance / speed
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", new_position, duration)
	# Update the current slot id
	set_on_slot_id(new_slot_id)
	await tween.finished
	move_tween_finished.emit()

func _on_reached_end_of_grid() -> void:
	deal_damage_to_player()
	die()

func deal_damage_to_player() -> void:
	Events.player_damaged.emit(self, %HealthComponent.current_health)

func die() -> void:
	print("Enemy died")
	queue_free()

func _on_death() -> void:
	die()

# called when a signal is received from a move component
func set_on_slot_id(slot_id: int) -> void:
	var previous_slot_id := on_slot_id
	on_slot_id = slot_id
	Events.emit_signal('enemy_moved_in_grid', self, slot_id, previous_slot_id) 

# check if on damaged slot when attack is signaled
func check_damage_event(_source: Node, target_slots: Array[int], amount: int) -> void:
	if on_slot_id in target_slots:
		%HealthComponent.take_damage(amount)

func move_enemy_to(target_slot: int) -> void:
	%GridMoveComponent.move_to_slot(target_slot)

func move_enemy_direction(direction: GEnums.DIR) -> void:
	print("Moving enemy in direction: ", direction)
	%GridMoveComponent.move_direction(direction)

# TODO remove this
# debugging
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_left"):
		%GridMoveComponent.move_left()
