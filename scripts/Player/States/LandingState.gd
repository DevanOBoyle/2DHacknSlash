extends State

class_name LandingState

@export var landing_animation : String = "Land"
@export var ground_state : State
@export var air_state : State
@export var jump_animation : String = "JumpAscend"
@export var idle_sprite : Sprite2D
@export var run_sprite : Sprite2D
@export var jump_sprite : Sprite2D

func on_enter():
	playback.travel(landing_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == landing_animation):
		next_state = ground_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	character.hide_animations()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state
