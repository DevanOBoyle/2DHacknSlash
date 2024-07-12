extends State

class_name EnemyHitGroundState

@export var idle_state : State

@export var knockback = -30
@export var is_knockedback : bool
@export var on_hit : String = "OnHitGround"

func state_process(delta):
	if character.is_hit:
		playback.start(on_hit, true)
		character.is_hit = false
	if (is_knockedback):
		character.velocity.x = character.direction.x * knockback
	else:
		character.velocity.x = 0
	
func on_enter():
	character.is_hit = false
	playback.travel(on_hit)
	is_knockedback = true
	
func on_exit():
	is_knockedback = false

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == on_hit:
		next_state = idle_state


