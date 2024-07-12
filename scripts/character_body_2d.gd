extends CharacterBody2D

# Constants (parametrized)
@export var speed: float = 400.0
@export var jump_velocity: float = -850.0
@export var can_double_jump: bool = true
@export var can_dash: bool = true
@export var dash_speed: float = 1200.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.3

# Node References
@onready var animated_sprite_2d = $AnimatedSprite2D

# Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var is_dashing = false
var dash_time_left = 0.0
var dash_cooldown_time = 0.0
var last_direction = 1  # 1 for right, -1 for left

# Initialization
func _ready():
	if Global.target_door_id != 0:
		position.x = Global.get_target_door_x()

# Physics and Input Handling
func _physics_process(delta):
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			is_dashing = false
			velocity.x = 0  # Stop dashing
	else:
		dash_cooldown_time -= delta
		apply_gravity(delta)
		handle_jump()
		handle_movement()
		handle_dash()
	handle_animation(velocity)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor() and not is_dashing:
		velocity.y += get_gravity(velocity) * delta

func handle_jump():
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jump_velocity / 4
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
			has_double_jumped = false
		elif can_double_jump and not has_double_jumped:
			velocity.y = jump_velocity
			has_double_jumped = true

func handle_movement():
	if not is_dashing:
		var direction = Input.get_axis("left", "right")
		if direction:
			last_direction = direction
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, 25)

func handle_dash():
	if can_dash and Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_time <= 0:
		is_dashing = true
		dash_time_left = dash_duration
		dash_cooldown_time = dash_cooldown
		velocity.y = 0  # Override vertical movement
		velocity.x = last_direction * dash_speed

# Animation Handling
func handle_animation(velocity: Vector2):
	if Input.get_axis("left", "right"):
		animated_sprite_2d.animation = "running"
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		animated_sprite_2d.animation = "default"
	
	if not is_on_floor() and not is_dashing:
		if velocity.y > 1:
			animated_sprite_2d.animation = "falling"
		else:
			animated_sprite_2d.animation = "jumping"
	
	if is_dashing:
		animated_sprite_2d.animation = "running"

# Utility Functions
func get_gravity(velocity: Vector2) -> float:
	return gravity if velocity.y < 0 else gravity * 1.5
