extends State

@export var wall_hold_name = "WallHold"
@export var wall_slide_name = "WallSlide"
@export var jump_animation : String = "JumpAscend"
@export var descend_animation : String = "JumpDescend"
@export var landing_animation : String = "Land"
@export var landing_state : State
@export var air_state : State
@export var jump_sprite : Sprite2D
@export var SLIDE_GRAVITY = 200
@onready var timer : Timer = $Timer
var hanging = true
var timer_started = false

func state_input(event: InputEvent):
	if (event.is_action_pressed("move_down")):
		playback.travel(wall_slide_name)
		hanging = false
		SLIDE_GRAVITY = 300
		character.velocity.y = SLIDE_GRAVITY
	elif (event.is_action_pressed("jump")):
		jump()
		
	
func state_process(delta):
	if (character.is_on_floor()):
		land()
	if (not character.is_on_wall()):
		if (not timer_started):
			timer.start()
			timer_started = true
			playback.travel(descend_animation)
		else:
			if (timer.is_stopped()):
				timer_started = false
				fall()
	elif (hanging):
		character.velocity.y = 0
	else:
		character.velocity.y = SLIDE_GRAVITY
	

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == wall_hold_name):
		playback.travel(wall_slide_name)
		hanging = false
	
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	playback.travel(jump_animation)
	next_state = air_state

func fall():
	playback.travel(descend_animation)
	next_state = air_state

func land():
	next_state = landing_state
	playback.travel(landing_animation)

func on_exit():
	hanging = true
	SLIDE_GRAVITY = 200
