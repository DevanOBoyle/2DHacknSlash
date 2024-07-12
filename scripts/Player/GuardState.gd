extends State

class_name GuardState

@export var ground_state : State
@export var guard_end_animation : String = "BlockEnd"
@export var idle_sprite : Sprite2D

func on_enter():
	pass
	
func state_process(delta):
	pass

func state_input(event):
	if (event.is_action_released("guard")):
		playback.travel(guard_end_animation)
	
func on_exit():
	character.hide_sprites()
	idle_sprite.show()

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == guard_end_animation):
		next_state = ground_state
