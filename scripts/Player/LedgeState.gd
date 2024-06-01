extends State

class_name LedgeState


@export var jump_animation : String = "JumpAscend"
@export var descend_animation : String = "JumpDescend"
@export var landing_animation : String = "Land"
@export var landing_state : State
@export var air_state : State

func state_process(delta):
	character.velocity.y = 0

func state_input(event):
	if (event.is_action_pressed("jump")):
		jump()

func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	air_state.from_wall = true;
	air_state.can_move = false;
	playback.travel(jump_animation)
	next_state = air_state

func on_enter():
	pass
	
func on_exit():
	pass
