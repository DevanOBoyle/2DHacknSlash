extends CharacterBody2D

class_name Player

const SPEED = 150.0
@export var speed_multiplier: float = 0.8
const JUMP_VELOCITY = -300
const RISING_ACCELERATION = -100
const FALL_GRAVITY = 2500
var rising_acceleration = 0
var fall_gravity = 0
var jump_pressed = false
var falling = false
var sprites : Array[Sprite2D]
var direction : Vector2 = Vector2.ZERO
var facing_right : bool = true
var locked_on : bool = false

@export var ground_state : State
@export var aerial_state : State

signal facing_direction_changed(facing_right : bool)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimationTree.active = true
	for child in get_children():
		if (child is Sprite2D):
			sprites.append(child)
	hide_animations()
	
func hide_animations() -> void:
	for sprite in sprites:
		sprite.hide()

func change_direction(direction : bool) -> void:
	for sprite in sprites:
		sprite.flip_h = direction

func update_facing_direction() -> void:
	if (direction.x < 0):
		change_direction(true)
		facing_right = false
	elif (direction.x > 0):
		change_direction(false)
		facing_right = true
	emit_signal("facing_direction_changed", facing_right)

func _input(event : InputEvent):
	if (event.is_action_pressed("lock_on")):
		locked_on = true
	if (event.is_action_released("lock_on")):
		locked_on = false

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if (-0.3 < direction.x and direction.x < 0.3):
		direction.x = 0
	if (direction.x > 0.98):
		direction.x = 1
	elif (direction.x < -0.98):
		direction.x = -1
	
	if direction.x != 0 and $PlayerStateMachine.check_if_can_move():
		velocity.x = direction.x * SPEED * speed_multiplier
		if (locked_on and $PlayerStateMachine.current_state == ground_state):
			velocity.x *= 0.5
		if ($PlayerStateMachine.current_state == aerial_state):
			velocity.x = direction.x * 120
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if (is_on_floor()): 
		rising_acceleration = RISING_ACCELERATION
		fall_gravity = 0
		
	#print(direction.x)
	#print(direction.y)
	move_and_slide()
	update_animation()
	if ($PlayerStateMachine.check_if_can_change_direction() and not locked_on):
		update_facing_direction()
	
func update_animation():
		$AnimationTree.set("parameters/Move/blend_position", direction.x)
		$AnimationTree.set("parameters/WalkRight/blend_position", direction.x)
		$AnimationTree.set("parameters/WalkLeft/blend_position", direction.x)
