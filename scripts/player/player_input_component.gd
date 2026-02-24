extends InputInterface
class_name PlayerInputComponent


@export var tool_controller: ToolController

func get_movement() -> Vector2:
	return super()

func process_input(event: InputEvent) -> void:
	handle_tool_cycle(event)
	super(event)


# Helpers
func handle_tool_cycle(event: InputEvent):
	if wants_cycle_next_tool(event):
		tool_controller.cycle_next()
	
	if wants_cycle_prev_tool(event):
		tool_controller.cycle_prev()
