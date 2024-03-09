extends State

class_name AirState

@export var idle_state : State

func state_process(delta):
	if (character.is_on_floor()):
		next_state = idle_state
	else:
		character.velocity.y += character.gravity * delta
	
func on_enter():
	pass
	
func on_exit():
	pass
