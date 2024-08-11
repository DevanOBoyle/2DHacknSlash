extends State

class_name AttackState

@export var attack1_name : String = "Attack1"
@export var attack1_2_name: String = "Attack1-2"
@export var attack2_name : String = "Attack2"
@export var attack2_2_name: String = "Attack2-2"
@export var attack2_3_name: String = "Attack2-3"
@export var attack2_4_name: String = "Attack2-4"
@export var attack3_name : String = "Attack3"
@export var attack_up_name : String = "AttackUp"
@export var attack_lunge_name : String = "AttackLunge"

@export var ground_state : State
@export var attack_sprite : Sprite2D
@export var move_animation : String = "Move"

@export var air_state : State
@export var jump_sprite : Sprite2D
@export var jump_animation : String = "JumpAscend"

var next_attack : String = attack1_name
var movement_attack3 = false
var movement_attack2_4 = false
var movement_lunge = false
@export var can_attack = false
@export var cancellable = false
@export var ATTACK_VELOCITY3 = 260
@export var ATTACK_VELOCITY2_4 = 240
@export var LUNGE_VELOCITY = 700
var has_attacked_next : bool = false

@onready var timer1 : Timer = $Timer
@onready var timer2 : Timer = $Timer2

func on_enter():
	timer1.start()
	timer2.start()
	character.velocity.x = 0

func on_exit():
	cancellable = false
	movement_attack3 = false
	movement_attack2_4 = false
	movement_lunge = false

func state_process(delta):
	if (movement_lunge):
		if (attack_sprite.flip_h == false):
			character.velocity.x = LUNGE_VELOCITY
		else:
			character.velocity.x = -1 * LUNGE_VELOCITY
	elif (movement_attack3):
		if (attack_sprite.flip_h == false):
			character.velocity.x = ATTACK_VELOCITY3
		else:
			character.velocity.x = -1 * ATTACK_VELOCITY3
	elif (movement_attack2_4):
		if (attack_sprite.flip_h == false):
			character.velocity.x = ATTACK_VELOCITY2_4
		else:
			character.velocity.x = -1 * ATTACK_VELOCITY2_4
	else:
		character.velocity.x = 0
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("attack")):
		manage_attack()
		timer1.start()
		has_attacked_next = true
	if event.is_action_pressed("jump") and cancellable:
		jump()
	if character.direction.x != 0 and cancellable:
		next_state = ground_state
		playback.travel(move_animation)
		
func attack_next():
	playback.travel(next_attack)

func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true
	character.hide_sprites()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state
	
func manage_attack() -> void:
	if (playback.get_current_node() == attack1_name):
		if (timer1.is_stopped()):
			#next_attack = attack1_2_name
			playback.travel(attack1_2_name)
			#next_state = ground_state
			#playback.travel(move_animation)
		else:
			#playback.travel(attack2_name)
			next_attack = attack2_name
			timer2.start()
			
	if (playback.get_current_node() == attack2_name):
		if (timer1.is_stopped()):
			#next_attack = attack2_2_name
			playback.travel(attack2_2_name)
			next_attack = ""
			#next_state = ground_state
			#playback.travel(move_animation)
		else:
			next_attack = attack3_name
			#playback.travel(attack3_name)
			
	if (playback.get_current_node() == attack2_2_name):
		#if (timer1.is_stopped()):
			#next_attack = attack2_3_name
			#next_state = ground_state
			#playback.travel(move_animation)
		#else:
		#playback.travel(attack2_3_name)
		next_attack = attack2_3_name
	
	if (playback.get_current_node() == attack2_3_name):
		#if (timer1.is_stopped()):
			#next_attack = attack2_4_name
			#next_state = ground_state
			#playback.travel(move_animation)
		#else:
		#playback.travel(attack2_4_name)
		next_attack = attack2_4_name

func _on_animation_tree_animation_finished(anim_name):
	if "Attack" in anim_name:
		can_attack = false
		next_attack = attack1_name
		next_state = ground_state
		playback.travel(move_animation)
		movement_attack3 = false
		movement_attack2_4 = false
		movement_lunge = false
