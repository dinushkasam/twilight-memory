extends State

@export
var idle_state: State

var movement_vector: Vector2

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	var new_state = handle_movement()
	update_animation()
	
	return new_state if new_state else null

func process_frame(_delta: float) -> State:
	return null


func handle_movement() -> State:
	movement_vector = input_component.get_movement()
	
	if movement_vector != Vector2.ZERO:
		# Read config
		var tile_aspect: Vector2 = self.parent.configs.tile_aspect
		var input_vector := Vector2(
			movement_vector.x * tile_aspect.x,
			movement_vector.y * tile_aspect.y
		)
		input_vector = input_vector.normalized()
		
		# y needs to be negative because in 2D, up is negative
		parent.last_facing_direction = Vector2(
			movement_vector.x,
			-movement_vector.y
		)
		
		# Read configs
		var move_speed := self.parent.configs.move_speed
		var acceleration := self.parent.configs.acceleration
		parent.velocity = input_vector * move_speed * acceleration
		parent.move_and_slide()
		return null
	else:
		return idle_state

func update_animation() -> void:
	parent.animation_tree.set("parameters/Walking/blend_position", parent.last_facing_direction)
