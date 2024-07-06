extends CharacterBody2D

signal player_start_playing;

@export var jump_period:float
var fly_begin_time = 0

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var jump_time = 0

var is_dead = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_moving = false
var is_jumping = false
var need_detect = true

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var timer = $Timer


func my_function():
	print("Function called after 1 second")
	need_detect = true
	timer.stop()

func die():
	visible = false
	is_dead = true
	game_manager.game_end()

func reset():
	is_moving = false
	is_jumping = false
	velocity.x = 0
	timer.start()
	

func _process(_delta):
	
	if (!need_detect || is_dead):
		return

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if not is_moving:
			# Player just started moving
			is_moving = true
			# Do something
	else:
		is_moving = false
		
	if Input.is_action_just_pressed("jump"):
		if not is_jumping:
			# Player just started jumping
			is_jumping = true
			# Do something
	else:
		is_jumping = false

	if (is_jumping || is_moving):
		need_detect = false
		emit_signal("player_start_playing")

func _ready():
	add_to_group("player_character")

func _physics_process(delta):
	if (is_dead || !is_moving):
		if not is_on_floor():
			velocity.y += gravity * delta

		move_and_slide()
		return
	
	if fly_begin_time == 0 and !is_on_floor():
		fly_begin_time = Time.get_ticks_msec()
	else:
		fly_begin_time = 0
		
	if is_on_floor():
		jump_time = 0

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor_in_period() and jump_time < 1:
		jump_time += 1
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func is_on_floor_in_period():
	if is_on_floor() or ((Time.get_ticks_msec() - fly_begin_time) < jump_period):
		return true
	return false
