extends State

class_name AirState

@export var landing_state : State
@export var descend_animation : String = "JumpDescend"
@export var landing_animation : String = "Land"
@export var jump_sprite : Sprite2D
const JUMP_VELOCITY = -300
const RISING_ACCELERATION = -100
const FALL_GRAVITY = 2500
var rising_acceleration = 0
var fall_gravity = 0
var jump_pressed = false
var falling = false


func state_input(event: InputEvent):
	if (character.velocity.y >= 0 and event.is_action_pressed("move_down")):
		fall_gravity = FALL_GRAVITY
		
	
func state_process(delta):
	if (character.is_on_floor()):
		next_state = landing_state
	if character.velocity.y >= 0:
		character.velocity.y += (character.gravity + fall_gravity) * delta
		if (falling != true):
			character.hide_animations()
			jump_sprite.show()
			playback.travel(descend_animation)
			falling = true
	elif character.velocity.y < 0:
		character.velocity.y += (character.gravity + rising_acceleration) * delta
		
	if (Input.is_action_just_released("jump")):
		jump_pressed = false
		rising_acceleration = character.gravity

	if (jump_pressed):
		if (rising_acceleration < 0):
			rising_acceleration += 5
		
func on_exit():
	if (next_state == landing_state):
		rising_acceleration = RISING_ACCELERATION
		fall_gravity = 0
		falling = false
		playback.travel(landing_animation)
		
