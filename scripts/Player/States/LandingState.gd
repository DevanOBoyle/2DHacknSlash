extends State

class_name LandingState

@export var landing_animation : String = "Land"
@export var ground_state : State
@export var air_state : State
@export var jump_animation : String = "JumpAscend"
@export var idle_sprite : Sprite2D
@export var run_sprite : Sprite2D
@export var jump_sprite : Sprite2D
@export var ground_collision : CollisionShape2D

@export var cancelable = false

func on_enter():
	character.hide_collisions()
	ground_collision.disabled = false
	playback.travel(landing_animation)
	
func _state_process():
	if (!character.is_on_floor()):
		air_state.from_ground = true
		next_state = air_state

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == landing_animation):
		next_state = ground_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	elif (character.direction.x != 0 and cancelable):
		next_state = ground_state
		
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	playback.travel(jump_animation)
	next_state = air_state

func on_exit():
	cancelable = false
