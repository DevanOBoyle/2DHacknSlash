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
@export var ground_state : State
@export var attack_sprite : Sprite2D
@export var move_animation : String = "Move"
var next_attack : String = attack1_name
var movement_attack3 = false
var movement_attack2_4 = false
var ATTACK_VELOCITY3 = 200
var ATTACK_VELOCITY2_4 = 190

@onready var timer1 : Timer = $Timer
@onready var timer2 : Timer = $Timer2

func on_enter():
	timer1.start()
	timer2.start()

func state_process(delta):
	if (movement_attack3):
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
		timer1.start()
	

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == attack1_name):
		if (timer1.is_stopped()):
			next_attack = attack1_2_name
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack2_name)
			timer2.start()
			
	if (anim_name == attack2_name):
		if (timer1.is_stopped()):
			next_attack = attack2_2_name
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack3_name)
			movement_attack3 = true
			
	if (anim_name == attack2_2_name):
		if (timer1.is_stopped()):
			next_attack = attack2_3_name
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack2_3_name)
	
	if (anim_name == attack2_3_name):
		if (timer1.is_stopped()):
			next_attack = attack2_4_name
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack2_4_name)
			movement_attack2_4 = true
			
	if (anim_name == attack3_name or anim_name == attack1_2_name or anim_name == attack2_4_name or anim_name == attack_up_name):
		next_attack = attack1_name
		next_state = ground_state
		playback.travel(move_animation)
		movement_attack3 = false
		movement_attack2_4 = false
	
		
