extends InputInterface
class_name WorldInputComponent

@export var camera: Camera2D

@export var camera_zoom_incement: Vector2 = Vector2(0.2, 0.2)
@export var camera_zoom_min: float = 1.2
@export var camera_zoom_max: float = 4.5

func get_movement() -> Vector2:
	return super()

func process_input(event: InputEvent) -> void:
	super(event)
	
	if super.wants_zoom_in():
		if camera.zoom.x < camera_zoom_max:
			camera.zoom = camera.zoom + camera_zoom_incement
	
	if super.wants_zoom_out():
		if camera.zoom.x > camera_zoom_min:
			camera.zoom = camera.zoom - camera_zoom_incement
