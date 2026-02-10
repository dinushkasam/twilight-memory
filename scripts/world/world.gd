extends Node2D

@onready var ground: TileMapLayer = $GroundTileMapLayer
@onready var highlight: TileMapLayer = $GroundHighlightTileMapLayer

@export var world_seed: NoiseTexture2D
@export var world_input_component: WorldInputComponent

const BASE_BLOCKS_ID = 2

const GRASS_BASE_ATLUS = Vector2i(0, 0)
const GRASS_CUT_ATLUS = Vector2i(1, 0)
const GRASS_1_ATLUS = Vector2i(2, 0)
const HIGHLIGHT_ATLUS = Vector2i(6, 0)
const SOIL_ATLUS = Vector2i(3, 0)
const BOUNDARY_ATLUS = Vector2i(0, 1)

var hovered_cell: Vector2i = Vector2i(-999, -999)
@onready var world_height = world_seed.height * 1.0
@onready var world_width = world_seed.width * 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_world_map()
	generate_boundaries()

func _process(_delta: float) -> void:
	update_hovered_tile()

func _input(event: InputEvent) -> void:
	select_cell_mouse_click(event)
	world_input_component.process_input(event)


func generate_world_map():
	for x in range(-world_height/2, world_height/2):
		for y in range(-world_width/2, world_width/2):
			# noise value is between -0.5 and + 0.5
			var noise = world_seed.noise.get_noise_2d(x, y)

			if noise >= 0.25:
				ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_BASE_ATLUS
				)
			elif noise >= 0:
				ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_CUT_ATLUS
				)
			elif noise >= -0.25:
				ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_1_ATLUS
				)
			else:
				ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					SOIL_ATLUS
				)


func generate_boundaries():
	const offsets = [
		Vector2i(0, -1),
		Vector2i(0, 1),
		Vector2i(-1, 0),
		Vector2i(1, 0)
	]
	var used = ground.get_used_cells()

	for tile in used:
		for offset in offsets:
			var current_tile = tile + offset
			if ground.get_cell_source_id(current_tile) == -1:
				ground.set_cell(current_tile, BASE_BLOCKS_ID, BOUNDARY_ATLUS)


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
			BASE_BLOCKS_ID,
			HIGHLIGHT_ATLUS
		)
		hovered_cell = cell


func select_cell_mouse_click(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if ground.get_cell_source_id(hovered_cell) != -1:
				print("Clicked tile: ", hovered_cell)
