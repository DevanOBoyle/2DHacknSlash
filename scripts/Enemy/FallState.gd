extends State

class_name FallState

@export var fall_animation : String = "Fall"
@export var landing_animation : String = "Land"
@export var idle_state : State
@export var air_state : State

var landed : bool = false

func on_enter():
	if character.is_on_floor():
		playback.travel(landing_animation)
		character.velocity.y = 0
		landed = true
	else:
		playback.travel(fall_animation)

func on_exit():
	landed = false
	
func state_process(delta):
	if character.is_hit and not landed:
		next_state = air_state
		character.is_hit = false
		character.knocked_up = false
		character.velocity.y = character.JUMP_VELOCITY * character.knockup_percent
		delta = 0
	if character.is_on_floor() and not landed:
		playback.travel(landing_animation)
		character.velocity.y = 0
		landed = true
	if not landed:
		character.velocity.y += (character.gravity + character.fall_gravity) * delta

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		next_state = idle_state
