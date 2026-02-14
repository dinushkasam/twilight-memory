extends Node
class_name InputInterface

# World State
var world_context: WorldContext

# Need to call the init function to inject dependencies
func init(context: WorldContext):
	world_context = context

func get_movement() -> Vector2:
	var up = Input.get_action_strength("up")
	var down = Input.get_action_strength("down")
	var left = Input.get_action_strength("left")
	var right = Input.get_action_strength("right")
	
	return Vector2(
		right - left,
		down - up
	)

func wants_zoom_in() -> bool:
	return true if Input.is_action_just_pressed("zoom_in") else false

func wants_zoom_out() -> bool:
	return true if Input.is_action_just_pressed("zoom_out") else false

func left_mouse_clicked(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			return true
	return false


func process_input(_event: InputEvent) -> void:
	pass
