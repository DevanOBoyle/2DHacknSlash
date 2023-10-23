extends State

class_name CrouchState

@export var air_state : State
@export var crouch_state : State
@export var attack_state : State
@export var stand_state : State
@export var attack_animation : String = "Crouch_Attack"
@export var jump_animation : String = "JumpAscend"
@export var stand_animation : String = "Crouch_End"
@export var jump_sprite : Sprite2D
@export var crouch_sprite : Sprite2D
var is_attacking : bool = false
var ATTACK_VELOCITY = 300

func state_process(delta):
	if (is_attacking):
		if (crouch_sprite.flip_h == false):
			character.velocity.x = ATTACK_VELOCITY
		else:
			character.velocity.x = -1 * ATTACK_VELOCITY
	else:
		character.velocity.x = 0

func state_input(event : InputEvent):
	if (event.is_action_released("move_down")):
		stand()
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()

func attack():
	is_attacking = true
	playback.travel(attack_animation)
	
	
func jump():
	is_attacking = false
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	character.hide_animations()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state

func stand():
	is_attacking = false
	playback.travel(stand_animation)
	next_state = stand_state

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Crouch_Attack"):
		playback.travel("Crouch_Idle")
		is_attacking = false
