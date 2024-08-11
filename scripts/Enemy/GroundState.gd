extends State

class_name EnemyIdleState

@export var air_state : State
@export var attack_state : State
@export var hit_state : State
@export var wait_animation : String = "Wait"
@export var next_direction : int = -1
@export var WALK_SPEED = 50
@onready var timer : Timer = $Timer

@export var ground_check : RayCast2D

# Called when the node enters the scene tree for the first time.
func state_process(delta):
	if character.is_on_wall() or not ground_check.is_colliding():
		character.direction.x *= -1
	character.velocity.x = character.direction.x * WALK_SPEED
	if character.knocked_up:
		next_state = air_state
		character.velocity.y = character.JUMP_VELOCITY
	elif character.is_hit:
		next_state = hit_state

func on_enter():
	timer.start()
	playback.travel(wait_animation)
	
func on_exit():
	pass

func _on_timer_timeout() -> void:
	if (character.direction.x != 0):
		character.direction.x = 0
		timer.wait_time = 2
	else:
		character.direction.x = next_direction
		timer.wait_time = 5
		next_direction *= -1

func _on_aggro_area_body_entered(body):
	if body.is_in_group("Player"):
		next_state = attack_state
