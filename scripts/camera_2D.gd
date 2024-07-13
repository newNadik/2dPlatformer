extends Camera2D

@onready var background_rect = $"../../../Background"

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
