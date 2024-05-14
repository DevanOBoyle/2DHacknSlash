extends Label

@export var animation_tree : AnimationTree
@export var state_machine : PlayerStateMachine
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Animation : " + animation_tree["parameters/playback"].get_current_node()
