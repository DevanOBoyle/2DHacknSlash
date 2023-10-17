extends State

class_name AttackState

@export var attack1_name : String = "Attack1"
@export var attack2_name : String = "Attack2"
@export var attack3_name : String = "Attack3"
@export var ground_state : State
@export var move_animation : String = "Move"

@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if (event.is_action_pressed("attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == attack1_name):
		if (timer.is_stopped()):
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack2_name)
			
	if (anim_name == attack2_name):
		if (timer.is_stopped()):
			next_state = ground_state
			playback.travel(move_animation)
		else:
			playback.travel(attack3_name)
	if (anim_name == attack3_name):
		next_state = ground_state
		playback.travel(move_animation)
