extends State

class_name AerialState

@export var air_state : State
@export var landing_state : State
@export var wall_state : State
@export var aerial_state : State
@export var aerial1_name : String = "Aerial1"
@export var aerial1_2_name: String = "Aerial1-2"
@export var aerial2_name : String = "Aerial2"
@export var aerial3_name: String = "Aerial3"
@export var aerial_down_name : String = "AerialDown"
@export var aerial_down_repeat_name : String = "AerialDownRepeat"
@export var landing_animation : String = "Land"
@export var descend_animation : String = "JumpDescend"
@export var wall_animation : String = "WallHold"
@export var attack_sprite : Sprite2D
@export var jump_sprite : Sprite2D
@export var AERIAL_VELOCITY1 = -30

var is_aerial1_2 = false
var is_aerial_down = false
var next_attack : String = aerial1_name
var can_aerial_1_2 : bool = true

@onready var timer1 : Timer = $Timer
@onready var timer2 : Timer = $Timer2

func on_enter():
	timer1.start()
	timer2.start()
	character.velocity.y = 0
	print(aerial_state.next_attack)

func state_input(event : InputEvent):
	if (event.is_action_pressed("attack")):
		timer1.start()
		
func state_process(delta):
	if (is_aerial_down):
		character.velocity.y += (character.gravity + character.FALL_GRAVITY) * delta
	elif (is_aerial1_2):
		character.velocity.y = AERIAL_VELOCITY1
	else:
		character.velocity.y += (character.gravity * 0.2) * delta
	if (character.is_on_floor()):
		change_state()

func change_state():
	is_aerial1_2 = false
	is_aerial_down = false
	if (character.is_on_floor()):
		next_state = landing_state
		character.hide_animations()
		jump_sprite.show()
		playback.travel(landing_animation)
	if (character.is_on_wall()):
		next_state = wall_state
		character.hide_animations()
		jump_sprite.show()
		playback.travel(wall_animation)
	else:
		next_state = air_state
		character.hide_animations()
		jump_sprite.show()
		playback.travel(descend_animation)
		
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == aerial1_name):
		if (timer1.is_stopped()):
			if can_aerial_1_2:
				next_attack = aerial1_2_name
			change_state()
		else:
			playback.travel(aerial2_name)
			timer2.start()
			
	if (anim_name == aerial1_2_name):
		is_aerial1_2 = false
		if (timer1.is_stopped()):
			next_attack = aerial2_name
			change_state()
		else:
			playback.travel(aerial2_name)
			
	if (anim_name == aerial2_name):
		if (timer1.is_stopped()):
			next_attack = aerial3_name
			change_state()
		else:
			playback.travel(aerial3_name)
			
	if (anim_name == aerial_down_name):
		is_aerial_down = true
		playback.travel(aerial_down_repeat_name)
		
	if (anim_name == aerial3_name):
		next_attack = aerial1_name
		change_state()
