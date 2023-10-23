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
@export var move_animation : String = "Move"
var next_attack : String = attack1_name

@onready var timer1 : Timer = $Timer
@onready var timer2 : Timer = $Timer2

func state_input(event : InputEvent):
	if (event.is_action_pressed("attack")):
		timer1.start()
		timer2.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == attack1_name):
		if (timer2.is_stopped()):
			next_attack = attack1_name
			next_state = ground_state
			playback.travel(move_animation)
		elif (timer1.is_stopped()):
			playback.travel(attack1_2_name)
		else:
			playback.travel(attack2_name)
			
	if (anim_name == attack2_name):
		if (timer2.is_stopped()):
			next_attack = attack2_2_name
			next_state = ground_state
			playback.travel(move_animation)
		if (timer1.is_stopped()):
			playback.travel(attack2_2_name)
		else:
			playback.travel(attack3_name)
			
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
			
	if (anim_name == attack3_name or anim_name == attack1_2_name or anim_name == attack2_4_name or anim_name == attack_up_name):
		next_attack = attack1_name
		next_state = ground_state
		playback.travel(move_animation)
