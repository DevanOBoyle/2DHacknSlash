extends State

class_name GroundState

@export var air_state : State
@export var crouch_state : State
@export var attack_state : State
@export var guard_state : State
@export var jump_animation : String = "JumpAscend"
@export var descend_animation : String = "JumpDescend"
@export var attack1_animation : String = "Attack1"
@export var attack1_2_animation : String = "Attack1-2"
@export var attack2_2_animation : String = "Attack2-2"
@export var attack_up_animation : String = "AttackUp"
@export var attack_lunge_animation : String = "Lunge"
@export var crouch_animation : String = "Crouch"
@export var guard_animation : String = "BlockStart"
@export var walk_animation : String = "Walk"
@export var reverse_walk_animation : String = "ReverseWalk"
@export var idle_sprite : Sprite2D
@export var jump_sprite : Sprite2D
@export var attack_sprite : Sprite2D
@export var crouch_sprite : Sprite2D
@export var guard_sprite : Sprite2D
@export var ground_collision : CollisionShape2D
@onready var timer : Timer = $Timer
var timer_started = false

func on_enter():
	character.hide_sprites()
	idle_sprite.show()
	playback.travel("Move")
	character.hide_collisions()
	ground_collision.disabled = false
	if character.locked_on:
		lock_on()
	

func state_process(delta):
	if (character.direction.y >= 0.7):
		crouch()
	if (!character.is_on_floor()):
		if (not timer_started):
			timer.start()
			timer_started = true
			playback.travel(descend_animation)
		else:
			if (timer.is_stopped()):
				timer_started = false
				next_state = air_state
	if (character.locked_on):
		character.velocity.x *= 0.5
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()
	if (event.is_action_pressed("guard")):
		guard()
	if (event.is_action_pressed("lock_on")):
		lock_on()
	if (event.is_action_released("lock_on")):
		release_lock_on()
		
func jump():
	character.velocity.y = character.JUMP_VELOCITY
	air_state.jump_pressed = true;
	character.hide_sprites()
	jump_sprite.show()
	playback.travel(jump_animation)
	next_state = air_state

func attack():
	character.hide_sprites()
	if (character.direction.y < -0.7):
		playback.travel(attack_up_animation)
	elif (character.locked_on and ((character.direction.x > 0.5 and character.facing_right) or (character.direction.x < -0.5 and not character.facing_right))):
		playback.travel(attack_lunge_animation)
	elif (attack_state.timer2.is_stopped()):
		playback.travel(attack1_animation)
	else:
		playback.travel(attack_state.next_attack)
	attack_sprite.show()
	next_state = attack_state

func crouch():
	character.hide_sprites()
	crouch_sprite.show()
	playback.travel(crouch_animation)
	next_state = crouch_state

func guard():
	character.hide_sprites()
	guard_sprite.show()
	playback.travel(guard_animation)
	next_state = guard_state

func lock_on():
	if (character.facing_right):
		playback.travel("WalkRight")
	if (not character.facing_right):
		playback.travel("WalkLeft")

func release_lock_on():
	playback.travel("Move")
