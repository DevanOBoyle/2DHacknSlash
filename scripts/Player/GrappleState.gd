extends State

class_name GrappleState

@export var air_state : State
@export var landing_state : State

var angular_acceleration = 0
var angular_velocity = 5
var arm_length = 20
var arm_multiplyer = 12
var angle = -0.71
var max_angle = 2.8

func state_process(delta):
	if angle >= max_angle:
		next_state = air_state
		
	angle += (5 * delta)
	if character.facing_right:
		character.velocity.x = arm_multiplyer * arm_length * sin(angle)
	else:
		character.velocity.x = -arm_multiplyer * arm_length * sin(angle)
		
	character.velocity.y = arm_multiplyer * arm_length * cos(angle)
	print(character.velocity.y)
	
	
func state_input(event):
	if (character.is_on_floor()):
		next_state = landing_state
	if (event.is_action_released("grapple")):
		next_state = air_state
	
func on_enter():
	character.velocity.y = 0
	if character.facing_right:
		angle = 0
	else:
		angle = 0
	
func on_exit():
	pass
