extends State

class_name LedgeState

@export var jump_animation : String = "JumpAscend"
@export var descend_animation : String = "JumpDescend"
@export var getup_animation : String = "LedgeGetUp"
@export var idle_sprite : Sprite2D
@export var ground_state : State
@export var air_state : State

func state_process(delta):
	character.velocity.y = 0
	if ((character.facing_right and character.direction.x > 0.9) or (not character.facing_right and character.direction.x < -0.9)):
		playback.travel(getup_animation)

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

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == getup_animation):
		next_state = ground_state
		character.position.y -= 19
		if character.facing_right:
			character.position.x += 16
		else:
			character.position.x -= 16
		character.hide_sprites()
		idle_sprite.show()
		playback.travel("Move")
