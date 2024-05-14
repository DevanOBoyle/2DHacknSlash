extends State

class_name EnemyAirState

@export var ground_state : State
@export var rising_acceleration : int = -100
@export var idle_animation : String = "Idle"

func state_process(delta):
	if (character.is_on_floor()):
		next_state = ground_state
	elif character.velocity.y >= 0:
		character.velocity.y += (character.gravity) * delta
	else:
		character.velocity.y += (character.gravity + rising_acceleration) * delta
	
func on_enter():
	pass
	
func on_exit():
	character.knocked_up = false
