extends Node

var target_door_id = 0

func set_target_door_id(door_id: int):
	target_door_id = door_id

func get_target_door_x() -> float:
	if Global.target_door_id != 0:
		var target_door = find_door_by_id(Global.target_door_id)
		if target_door:
			target_door.pause_door(0.2)
			Global.set_target_door_id(0)
			return target_door.position.x + target_door.get("door_direction") * 10
	return 0

func find_door_by_id(door_id: int) -> Node2D:
	var nodes = get_tree().get_nodes_in_group("Doors")
	for node in nodes:
		if node.get("door_id") == door_id:
			return node
	return null
