extends CharacterBody2D

class_name Player

const SPEED = 150.0
@export var speed_multiplier: float = 1.0
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

func update_facing_direction() -> void:
	if (direction.x < 0):
		facing_right = false
		for sprite in sprites:
			sprite.flip_h = true
	elif (direction.x > 0):
		facing_right = true
		for sprite in sprites:
			sprite.flip_h = false

func _physics_process(delta: float) -> void:

	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction.x != 0 && $PlayerStateMachine.check_if_can_move():
		velocity.x = direction.x * SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if (is_on_floor()): 
		rising_acceleration = RISING_ACCELERATION
		fall_gravity = 0
		

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	$AnimationTree.set("parameters/Move/blend_position", direction.x)
	
