extends CollisionShape2D

@export var player : Player
@export var facing_left_position : Vector2 = Vector2(-position.x, position.y)
@export var facing_right_position : Vector2 =  Vector2(position.x, position.y)

func _ready():
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_player_facing_direction_changed(facing_right: bool):
	if (facing_right):
		position = facing_right_position
	else:
		position = facing_left_position
