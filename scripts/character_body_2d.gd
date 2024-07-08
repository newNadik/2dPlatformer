extends CharacterBody2D

# Constants
const SPEED = 400.0
const JUMP_VELOCITY = -850.0

# Node References
@onready var animated_sprite_2d = $AnimatedSprite2D

# Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Initialization
func _ready():
	pass  # Any initialization code can go here

# Physics and Input Handling
func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement()
	handle_animation(velocity)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta

func handle_jump():
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func handle_movement():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 25)

# Animation Handling
func handle_animation(velocity: Vector2):
	if Input.get_axis("left", "right"):
		animated_sprite_2d.animation = "running"
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		animated_sprite_2d.animation = "default"
	
	if not is_on_floor():
		if velocity.y > 1:
			animated_sprite_2d.animation = "falling"
		else:
			animated_sprite_2d.animation = "jumping"

# Utility Functions
func get_gravity(velocity: Vector2) -> float:
	if velocity.y < 0:
		return gravity
	return gravity * 1.5
