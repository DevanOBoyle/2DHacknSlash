extends Camera2D
@onready var player = get_node("../Player")
@onready var camera = get_node("../Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player.facing_right):
		camera.drag_left_margin = 0.4
		camera.drag_right_margin = 0
		if (camera.offset.x < 35):
			camera.offset.x += 0.25
	else:
		camera.drag_left_margin = 0
		camera.drag_right_margin = 0.4
		if (camera.offset.x > -35):
			camera.offset.x -= 0.25
