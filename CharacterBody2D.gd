#by: @lostvoidcat
#about code: simple movement, wall jump, and slide

extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -460
var gravity = 1000

var can_move_left: bool = true
var can_move_right: bool = true
var time_stamp_wall_jump: int = 0

func get_input():
	pass

func _physics_process(delta):
	
	if Time.get_ticks_msec() - time_stamp_wall_jump >= 320:
		can_move_left = true
		can_move_right = true
	
	if is_on_floor():
		velocity.x = 0
	if Input.is_action_pressed("right_input") and can_move_right:
		velocity.x = SPEED
	elif Input.is_action_pressed("left_input")and can_move_left:
		velocity.x = -SPEED
		
	if is_on_floor() and Input.is_action_pressed("jump_input"):
		velocity.y = JUMP_VELOCITY
	
	elif is_on_wall() and Input.is_action_pressed("left_input") and can_move_left and velocity.y > -1:
		velocity.y += gravity/6 * delta
		
		if Input.is_action_just_pressed("jump_input"):
			time_stamp_wall_jump = Time.get_ticks_msec()
			can_move_left = false
			velocity.y = -250
			velocity.x = 175
		
	elif is_on_wall() and Input.is_action_pressed("right_input") and can_move_right and velocity.y > -1:
		velocity.y += gravity/6 * delta
		
		if Input.is_action_just_pressed("jump_input"):
			time_stamp_wall_jump = Time.get_ticks_msec()
			can_move_right = false
			velocity.y = -250
			velocity.x = -175
		
	else: velocity.y += gravity * delta
	move_and_slide()










