extends State

class_name EnemyRunState

var player : CharacterBody2D
@export var RUN_SPEED = 100
@export var idle_state : State
@export var attack_state : State
@export var hit_state : State
@export var run_animation : String = "Run"


func on_enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	playback.travel(run_animation)

func get_direction():
	if (character.global_position.x < (player.global_position.x - 30)):
		character.direction.x = 1
	elif (character.global_position.x > (player.global_position.x + 30)):
		character.direction.x = -1
	else:
		character.direction.x = 0
	
func state_process(delta):
	if character.is_hit:
		next_state = hit_state
	get_direction()
	character.velocity.x = character.direction.x * RUN_SPEED
	
func _on_aggro_area_body_exited(body):
	next_state = idle_state

func _on_combat_area_body_entered(body):
	next_state = attack_state
