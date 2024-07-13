extends Node2D

@export var max_offset: float = 256
@export var speed: float = 512
var default_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	default_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("up", "down")
	var movement = direction * speed * delta  # Calculate the movement based on the direction, speed, and frame delta
	
	# Move if there is an input and within the max_offset boundary
	if direction != 0 and abs(position.y - default_pos.y + movement) <= max_offset:
		position.y += movement
	elif direction == 0 and position.y != default_pos.y:
		# Smoothly move back to default position if no input
		var move_back = speed * delta
		if abs(position.y - default_pos.y) <= move_back:
			position.y = default_pos.y
		elif position.y > default_pos.y:
			position.y -= move_back
		else:
			position.y += move_back
