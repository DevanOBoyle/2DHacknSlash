extends State

class_name StandState

@export var stand_animation_name : String = "Crouch_End"
@export var ground_state : State
@export var air_state : State
@export var jump_animation : String = "JumpAscend"
@export var jump_sprite : Sprite2D

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == stand_animation_name):
		next_state = ground_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	character.hide_sprites()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state
