extends CharacterBody2D

class_name Enemy

@onready var sprite = $Sprite2D

const SPEED = 50.0
@export var speed_multiplier: float = 1
const JUMP_VELOCITY = -300
const RISING_ACCELERATION = -100
const FALL_GRAVITY = 2500
var rising_acceleration = 0
var fall_gravity = 0
var jump_pressed = false
var falling = false
var sprites : Array[Sprite2D]
var direction : Vector2 = Vector2.ZERO
var facing_right : bool = false
var knocked_up : bool = false
@export var ground_check_length = 7

signal facing_direction_changed(facing_right : bool)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimationTree.active = true
	sprite.show()

func change_direction(direction : bool) -> void:
	sprite.flip_h = direction
	if (direction):
		$GroundCheck.position.x = ground_check_length
	else:
		$GroundCheck.position.x = -ground_check_length
	facing_right = direction

func update_facing_direction() -> void:
	if (direction.x > 0):
		change_direction(true)
		facing_right = true
	elif (direction.x < 0):
		change_direction(false)
		facing_right = false
	emit_signal("facing_direction_changed", facing_right)

func _physics_process(delta: float) -> void:
	#if direction.x != 0 && $EnemyStateMachine.check_if_can_move():
		#velocity.x = direction.x * SPEED * speed_multiplier
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	if (is_on_floor()):
		rising_acceleration = RISING_ACCELERATION
		fall_gravity = 0
		
	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	$AnimationTree.set("parameters/Wait/blend_position", direction.x)
