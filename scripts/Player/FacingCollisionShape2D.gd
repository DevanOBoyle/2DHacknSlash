extends CollisionShape2D

class_name FacingCollisionShape2D

@export var facing_left_position : Vector2 = Vector2(position.x, position.y)
@export var facing_right_position : Vector2 =  Vector2(-position.x, position.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
