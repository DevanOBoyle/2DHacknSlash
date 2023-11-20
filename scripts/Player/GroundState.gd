extends State

class_name GroundState

@export var air_state : State
@export var crouch_state : State
@export var attack_state : State
@export var jump_animation : String = "JumpAscend"
@export var attack1_animation : String = "Attack1"
@export var attack1_2_animation : String = "Attack1-2"
@export var attack2_2_animation : String = "Attack2-2"
@export var attack_up_animation : String = "AttackUp"
@export var crouch_animation : String = "Crouch"
@export var idle_sprite : Sprite2D
@export var run_sprite : Sprite2D
@export var jump_sprite : Sprite2D
@export var attack_sprite : Sprite2D
@export var crouch_sprite : Sprite2D

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
	elif (character.direction.y > 0):
		crouch()
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
	if (event.is_action_pressed("move_down")):
		crouch()
		
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
	if (character.direction.y < 0):
		playback.travel(attack_up_animation)
	elif (attack_state.timer2.is_stopped()):
		print("hi")
		playback.travel(attack1_animation)
	else:
		print("hello")
		playback.travel(attack_state.next_attack)
	next_state = attack_state

func crouch():
	character.hide_animations()
	crouch_sprite.show()
	playback.travel(crouch_animation)
	next_state = crouch_state
