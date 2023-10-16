extends State

class_name GroundState

@export var air_state : State
@export var attack_state : State
@export var jump_animation : String = "JumpAscend"
@export var attack_animation : String = "Attack1"
@export var idle_sprite : Sprite2D
@export var run_sprite : Sprite2D
@export var jump_sprite : Sprite2D
@export var attack_sprite : Sprite2D

func on_enter():
	if (character.velocity.x != 0):
		character.hide_animations()
		run_sprite.show()
	elif (character.velocity.x == 0):
		character.hide_animations()
		idle_sprite.show()

func state_process(delta):
	if (!character.is_on_floor()):
		next_state = air_state
	elif (character.velocity.x != 0):
		character.hide_animations()
		run_sprite.show()
	elif (character.velocity.x == 0):
		character.hide_animations()
		idle_sprite.show()

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()
		
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	character.hide_animations()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state

func attack():
	character.hide_animations()
	attack_sprite.show()
	playback.travel(attack_animation)
	next_state = attack_state
