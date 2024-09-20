extends CharacterBody2D

class_name Enemy

@onready var sprite = $Sprite2D

const SPEED = 50.0
@export var speed_multiplier: float = 1
const JUMP_VELOCITY = -300
const RISING_ACCELERATION = -100
const FALL_GRAVITY = 2000
var rising_acceleration = 0
var fall_gravity = -500
var jump_pressed = false
var falling = false
var sprites : Array[Sprite2D]
var direction : Vector2 = Vector2.ZERO
var facing_right : bool = false
var knocked_up : bool = false
var knockup_percent : float = 1
var is_hit : bool = false
var attack_landed : bool = false
@export var ground_check_length = 7

@export var state_machine : PlayerStateMachine
@export var hit_state : State
@export var air_state : State
@export var is_aggroed : bool = false
@export var is_attacking: bool = false

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

func _on_aggro_area_body_entered(body):
	if body.is_in_group("Player"):
		is_aggroed = true
		
func _physics_process(delta: float) -> void:
	#if is_hit and knocked_up:
		#state_machine.current_state.next_state = air_state
	#elif is_hit:
		#state_machine.current_state.next_state = hit_state
	#if direction.x != 0 && $EnemyStateMachine.check_if_can_move():
		#velocity.x = direction.x * SPEED * speed_multiplier
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	if (is_on_floor()):
		rising_acceleration = RISING_ACCELERATION
		
	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	$AnimationTree.set("parameters/Wait/blend_position", direction.x)


func _on_aggro_area_body_exited(body):
	if body.is_in_group("Player"):
		is_aggroed = false

func _on_combat_area_body_exited(body):
	if body.is_in_group("Player"):
		is_attacking = false
