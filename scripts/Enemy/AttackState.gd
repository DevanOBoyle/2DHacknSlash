extends State

class_name EnemyAttackState

var player : CharacterBody2D
@export var RUN_SPEED = 100
@export var idle_state : State
@export var run_animation : String = "Run"


func on_enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	playback.travel(run_animation)

func get_direction():
	if (character.global_position < player.global_position):
		character.direction.x = 1
	elif (character.global_position > player.global_position):
		character.direction.x = -1
	else:
		character.direction.x = 0
	
func state_process(delta):
	get_direction()
	character.velocity.x = character.direction.x * RUN_SPEED

func _on_aggro_area_body_exited(body):
	if body.is_in_group("Player"):
		next_state = idle_state
