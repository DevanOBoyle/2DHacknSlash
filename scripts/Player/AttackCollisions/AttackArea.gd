extends Area2D

class_name AttackArea

@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingCollisionShape2D
@export var is_knockup : bool = false
@export var knockup_percent : float = 0.5

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	player.attack_landed = true
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage, is_knockup, knockup_percent)

func _input(event : InputEvent):
	if (event.is_action_pressed("attack")):
		if (player.facing_right):
			facing_shape.position = facing_shape.facing_right_position
		else:
			facing_shape.position = facing_shape.facing_left_position

func _on_player_facing_direction_changed(facing_right: bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
 
func _end_monitoring():
	monitoring = false
