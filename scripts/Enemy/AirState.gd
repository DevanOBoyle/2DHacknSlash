extends State

class_name EnemyAirState

@export var fall_state : State
@export var rising_acceleration : int = -100
@export var idle_animation : String = "Idle"
@export var falling_animation : String = "Fall"
@export var landing_animation : String = "Land"
@export var on_hit_animation : String = "OnHitAir"

func state_process(delta):
	if character.is_hit:
		playback.start(on_hit_animation, true)
		character.is_hit = false
		character.knocked_up = false
		character.velocity.y = character.JUMP_VELOCITY
	if (character.is_on_floor()):
		next_state = fall_state
	elif character.velocity.y >= 0:
		character.velocity.y += (character.gravity) * delta
	else:
		character.velocity.y += (character.gravity + rising_acceleration) * delta
	
func on_enter():
	character.is_hit = false
	character.knocked_up = false
	playback.travel(on_hit_animation)
	
func on_exit():
	pass
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == on_hit_animation:
		next_state = fall_state
