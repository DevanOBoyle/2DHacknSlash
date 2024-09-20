extends State

class_name BackdashState

@export var ground_state : State
@export var ground_sprite : Sprite2D
@export var is_dashing : bool = false
@export var backdash_animation : String = "Backdash"

const DASH_VELOCITY = -450

func state_process(delta):
	if is_dashing:
		if (ground_sprite.flip_h == false):
			character.velocity.x = DASH_VELOCITY
		else:
			character.velocity.x = -1 * DASH_VELOCITY
	else:
		character.velocity.x = 0
	
func on_enter():
	is_dashing = false
	character.velocity.x = 0

func on_exit():
	is_dashing = false
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == backdash_animation:
		next_state = ground_state
