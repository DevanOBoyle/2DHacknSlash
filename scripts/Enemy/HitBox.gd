extends CollisionShape2D

@export var enemy : Enemy
@export var facing_left_position : Vector2
@export var facing_right_position : Vector2

func _ready():
	enemy.connect("facing_direction_changed", _on_enemy_facing_direction_changed)

func _on_enemy_facing_direction_changed(facing_right: bool):
	if (facing_right):
		position = facing_right_position
	else:
		position = facing_left_position
