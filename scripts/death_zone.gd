extends Area2D

func _on_body_entered(body):
	if body.name == "Player":  # Ensure the body is the player
		get_tree().reload_current_scene()
