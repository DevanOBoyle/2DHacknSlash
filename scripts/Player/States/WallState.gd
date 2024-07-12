extends State

class_name WallState

@export var wall_hold_animation = "WallHold"
@export var jump_animation : String = "JumpAscend"
@export var descend_animation : String = "JumpDescend"
@export var landing_animation : String = "Land"
@export var landing_state : State
@export var air_state : State
@export var SLIDE_GRAVITY = 200
@onready var grace_timer : Timer = $JumpGraceTimer
@onready var slide_timer : Timer = $SlideTimer
var hanging = true
var grace_timer_started = false

func on_enter():
	can_move = true
	if (character.get_wall_normal().x == 1):
		character.change_direction(true)
	else:
		character.change_direction(false)
	playback.travel(wall_hold_animation)
	slide_timer.start()

func state_input(event: InputEvent):
	if (event.is_action_pressed("move_down")):
		hanging = false
		SLIDE_GRAVITY = 300
		character.velocity.y = SLIDE_GRAVITY
	if (event.is_action_pressed("jump")):
		jump()
		
	
func state_process(delta):
	character.velocity.x = character.direction.x * -200     
	if (character.is_on_floor()):
		land()
	if (not character.is_on_wall()):
		if (not grace_timer_started):
			grace_timer.start()
			grace_timer_started = true
			playback.travel(descend_animation)
		else:
			if (grace_timer.is_stopped()):
				grace_timer_started = false
				fall()
	elif (hanging):
		character.velocity.y = 0
	else:
		character.velocity.y = SLIDE_GRAVITY
	
func jump():
	grace_timer.stop()
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	air_state.from_wall = true;
	air_state.can_move = false;
	if (character.get_wall_normal().x == 1):
		character.change_direction(false)
	else:
		character.change_direction(true)
	playback.travel(jump_animation)
	can_move = false
	next_state = air_state

func fall():
	air_state.from_wall = true;
	playback.travel(descend_animation)
	next_state = air_state

func land():
	next_state = landing_state
	playback.travel(landing_animation)

func on_exit():
	hanging = true
	SLIDE_GRAVITY = 200
	slide_timer.stop()

func _on_slide_timer_timeout():
	hanging = false
