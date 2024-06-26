extends State

class_name AirState

@export var landing_state : State
@export var wall_state : State
@export var ledge_state : State
@export var aerial_state : State
@export var grapple_state : State
@export var descend_animation : String = "JumpDescend"
@export var landing_animation : String = "Land"
@export var wall_animation : String = "WallHold"
@export var ledge_animation : String = "LedgeHold"
@export var aerial1_animation : String = "Aerial1"
@export var aerial1_2_animation: String = "Aerial1-2"
@export var aerial_down_animation: String = "AerialDown"
@export var jump_sprite : Sprite2D
@export var attack_sprite : Sprite2D
@export var air_collision : CollisionShape2D
@export var raycast : RayCast2D
const JUMP_VELOCITY = -300
const RISING_ACCELERATION = -100
const FALL_GRAVITY = 2500
var rising_acceleration = 0
var fall_gravity = 150
var jump_pressed = false
var falling = false
var from_wall = false
var wall_jump_multiplier = 2

var AERIAL_GRAVITY = -200
var AERIAL_VELOCITY1 = -30
var aerial_gravity = 0

func on_enter():
	character.hide_collisions()
	air_collision.disabled = false
	if (from_wall == true):
		can_move = false

func state_input(event: InputEvent):
	if (character.velocity.y >= 0 and character.direction.y >= 0.7):
		fall_gravity = FALL_GRAVITY
	if (event.is_action_pressed("attack")):
		attack()
	if (event.is_action_pressed("grapple")):
		grapple()

func check_facing_direction():
	if (character.get_wall_normal().x == 1 and character.facing_right):
		return false
	if (character.get_wall_normal().x == -1 and not character.facing_right):
		return false
	return true
	
func attack():
	character.hide_animations()
	attack_sprite.show()
	if (character.direction.y >= 0.7):
		playback.travel(aerial_down_animation)
	elif (aerial_state.timer2.is_stopped()):
		playback.travel(aerial1_animation)
	else:
		if (aerial_state.next_attack == "Aerial1-2"):
			aerial_state.is_aerial1_2 = true
			if aerial_state.can_aerial_1_2:
				playback.travel(aerial_state.next_attack)
			aerial_state.can_aerial_1_2 = false
		else:
			playback.travel(aerial_state.next_attack)
	next_state = aerial_state

func grapple():
	next_state = grapple_state
			
func state_process(delta):
	if (character.is_on_floor()):
		character.hide_animations()
		jump_sprite.show()
		playback.travel(landing_animation)
		next_state = landing_state
	if (character.is_on_wall()):
		character.hide_animations()
		jump_sprite.show()
		if (not raycast.is_colliding() and check_facing_direction()):
			next_state = ledge_state
		else:
			next_state = wall_state
	if character.velocity.y >= 0:
		character.velocity.y += (character.gravity + fall_gravity) * delta
		if (falling != true):
			character.hide_animations()
			jump_sprite.show()
			playback.travel(descend_animation)
			falling = true
			can_move = true
	elif character.velocity.y < 0:
		character.velocity.y += (character.gravity + rising_acceleration) * delta
		if (from_wall):
			can_move = false
			character.velocity.x = character.get_wall_normal().x * character.SPEED * wall_jump_multiplier
		
	if (Input.is_action_just_released("jump")):
		jump_pressed = false
		rising_acceleration = character.gravity

	if (jump_pressed):
		if (rising_acceleration < 0):
			rising_acceleration += 5

func on_exit():
	rising_acceleration = RISING_ACCELERATION
	fall_gravity = 150
	falling = false
	from_wall = false
	can_move = true
	if (next_state == landing_state):
		aerial_state.can_aerial_1_2 = true
	if (next_state == wall_state):
		playback.travel(wall_animation)
	if (next_state == ledge_state):
		playback.travel(ledge_animation)
