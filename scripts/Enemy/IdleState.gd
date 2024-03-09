extends State

class_name EnemyIdleState

@export var air_state : State

@export var next_direction : int = -1
@onready var timer : Timer = $Timer

func state_process(delta):
	if (not character.is_on_floor()):
		next_state = air_state
	
func on_enter():
	timer.start()
	
func on_exit():
	pass

func _on_timer_timeout() -> void:
	if (character.direction.x != 0):
		character.direction.x = 0
		timer.wait_time = 2
	else:
		character.direction.x = next_direction
		timer.wait_time = 5
		next_direction *= -1
