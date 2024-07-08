extends Camera2D

@onready var background_rect = $"../../TextureRect"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_limits()

func set_limits():
	if background_rect:
		var map_rect = background_rect.get_rect()

		limit_left = map_rect.position.x
		limit_right = map_rect.position.x + map_rect.size.x
		limit_top = map_rect.position.y
		limit_bottom = map_rect.position.y + map_rect.size.y

		# Adjust the limits based on the screen size
		#var screen_size = get_viewport().size
		#limit_right -= screen_size.x
		#limit_bottom -= screen_size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
