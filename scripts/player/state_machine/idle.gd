extends State

@export
var walk_state: State

var movement_vector: Vector2

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	var new_state = handle_movement()
	parent.animation_tree.set("parameters/Idle/blend_position", parent.last_facing_direction)
	
	return new_state if new_state else null

func process_frame(_delta: float) -> State:
	return null

func handle_movement() -> State:
	movement_vector = input_component.get_movement()
	
	if movement_vector == Vector2.ZERO:
		parent.velocity = movement_vector
	else:
		return walk_state
	
	return null
