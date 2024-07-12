extends Area2D

class_name EnemyAttackArea

@export var damage : int = 10
@export var enemy: Enemy
@export var facing_shape : FacingCollisionShape2D
@export var is_knockup : bool = false
@export var attack_state : State

func _ready():
	monitoring = false
	enemy.connect("facing_direction_changed", _on_enemy_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage, is_knockup)

func _physics_process(delta):
	if (attack_state.is_attacking):
		if (enemy.facing_right):
			facing_shape.position = facing_shape.facing_right_position
		else:
			facing_shape.position = facing_shape.facing_left_position

func _on_enemy_facing_direction_changed(facing_right: bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
	
