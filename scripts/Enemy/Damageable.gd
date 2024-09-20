extends Node

class_name Damageable

@export var character = CharacterBody2D

@export var health : float = 100 :
	get :
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int, is_knockup : bool, knockup_percent: float = 1):
	health -= damage
	
	character.knocked_up = is_knockup
	character.knockup_percent = knockup_percent
	character.is_hit = true
	if (health <= 0):
		pass
		# get_parent().queue_free()
