extends Area2D

# Exported Variables
@export var target_scene_path = ""
@export var target_door_id = 1
@export var door_id = 1
@export var door_direction = 1

# Variables
var paused: bool = false
var pause_timer: Timer

# Initialization
func _ready():
	add_to_group("Doors")
	pause_timer = Timer.new()
	add_child(pause_timer)
	pause_timer.connect("timeout", Callable(self, "_on_pause_timeout"))

# Body Entered Handling
func _on_body_entered(body):
	if paused:
		return

	if body.is_in_group("Player"):
		if target_scene_path.is_empty():
			var current_scene_file = get_tree().current_scene.scene_file_path
			var next_level_number = current_scene_file.to_int() + 1
			target_scene_path = "res://scenes/levels/level" + str(next_level_number) + ".tscn"
		call_deferred("_change_scene")

# Scene Change Handling
func _change_scene():
	Global.set_target_door_id(target_door_id)
	get_tree().change_scene_to_file(target_scene_path)

# Door Pause/Resume Functions
func pause_door(duration: float = 0):
	paused = true
	if duration > 0:
		pause_timer.start(duration)

func resume_door():
	paused = false

# Pause Timeout Callback
func _on_pause_timeout():
	resume_door()
