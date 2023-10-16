extends State

class_name AttackState

@export var attack_animation_name : String = "Attack1"
@export var ground_state : State

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == attack_animation_name):
		next_state = ground_state
