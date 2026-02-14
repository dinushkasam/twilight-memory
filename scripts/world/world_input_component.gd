extends InputInterface
class_name WorldInputComponent

@export var camera: Camera2D

@export var camera_zoom_incement: Vector2 = Vector2(0.2, 0.2)
@export var camera_zoom_min: float = 1.2
@export var camera_zoom_max: float = 4.5

const BASE_BLOCKS_ID = 2
const HIGHLIGHT_ATLUS = Vector2i(6, 0)


# Main entry functions
func process_input(event: InputEvent) -> void:
	# Handle camera zoom-in input
	handle_camera_zoom_in()
	
	# Handle camera zoom-out input
	handle_camera_zoom_out()
	
	# Handle mouse click event and emit signal
	handle_left_click(event)

func process_updates():
	handle_cell_hover()


# Helper functions
func handle_camera_zoom_in():
	if super.wants_zoom_in():
		if camera.zoom.x < camera_zoom_max:
			camera.zoom = camera.zoom + camera_zoom_incement

func handle_camera_zoom_out():
	if super.wants_zoom_out():
		if camera.zoom.x > camera_zoom_min:
			camera.zoom = camera.zoom - camera_zoom_incement

func handle_left_click(event):
	if super.left_mouse_clicked(event):
		if world_context.ground.get_cell_source_id(world_context.highlighted_cell) != -1:
				world_context.tile_clicked.emit(world_context.highlighted_cell)

func handle_cell_hover():
	var cell := world_context.get_hovered_cell()
	if cell == world_context.highlighted_cell:
		return

	world_context.highlight.clear()

	if world_context.ground.get_cell_source_id(cell) != -1:
		world_context.highlight.set_cell(
			cell,
			BASE_BLOCKS_ID,
			HIGHLIGHT_ATLUS
		)
		world_context.highlighted_cell = cell
