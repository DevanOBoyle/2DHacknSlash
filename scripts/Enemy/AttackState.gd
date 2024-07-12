extends State

class_name EnemyAttackState

@export var run_state : State
@export var hit_state : State
@export var run_attack : String = "RunAttack"
@export var combat_idle : String = "CombatIdle"

var is_attacking : bool = false
var exited : bool = false

func state_process(delta):
	if character.is_hit:
		next_state = hit_state
	if can_move:
		character.velocity.x = character.SPEED * 1.5 * character.direction.x
	else:
		character.velocity.x = 0
	if exited == true and not is_attacking:
		next_state = run_state
	
func on_enter():
	playback.travel(run_attack)
	is_attacking = true
	
func on_exit():
	exited = false

func _on_combat_area_body_exited(body):
	if not is_attacking:
		next_state = run_state
	else:
		exited = true

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == run_attack):
		playback.travel(combat_idle)
		is_attacking = false
