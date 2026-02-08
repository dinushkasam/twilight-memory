extends Node
class_name InputInterface


func get_movement() -> Vector2:
	var up = Input.get_action_strength("ui_up")
	var down = Input.get_action_strength("ui_down")
	var left = Input.get_action_strength("ui_left")
	var right = Input.get_action_strength("ui_right")
	
	return Vector2(
		right - left,
		down - up
	)

func process_input(_event: InputEvent) -> void:
	pass
