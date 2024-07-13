extends Area2D

@export var respawn: Node2D

func _on_body_entered(body):
	if body.name == "Player": 
		if respawn == null: # Ensure the body is the player
			get_tree().reload_current_scene()
		else:
			body.position = respawn.global_position
			body.velocity = Vector2.ZERO
