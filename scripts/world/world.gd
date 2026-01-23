extends Node2D

@onready var ground: TileMapLayer = $GroundTileMapLayer
@onready var highlight: TileMapLayer = $GroundHighlightTileMapLayer
@onready var player := $Player

var hovered_cell: Vector2i = Vector2i(-999, -999)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_test_map()

func _process(_delta: float) -> void:
	update_hovered_tile()

func _input(event: InputEvent) -> void:
	select_cell_mouse_click(event)


func generate_test_map():
	var size := 10
	for x in range(size):
		for y in range(size):
			ground.set_cell(
				Vector2i(x - (size / 2), y - (size / 2)),
				0,
				Vector2i(0, 0)
			)


func update_hovered_tile():
	var mouse_position := get_global_mouse_position()
	
	var local_position := ground.to_local(mouse_position)
	var cell := ground.local_to_map(local_position)
	
	if cell == hovered_cell:
		return
		
	highlight.clear()
	
	if ground.get_cell_source_id(cell) != -1:
		highlight.set_cell(
			cell,
			1,
			Vector2i(0, 0)
		)
		hovered_cell = cell


func select_cell_mouse_click(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if ground.get_cell_source_id(hovered_cell) != -1:
				print("Clicked tile: ", hovered_cell)
	
