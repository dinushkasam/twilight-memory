extends Node
class_name WorldGeneratorComponent


# Random seeds (Perlin noise)
@export var world_seed: NoiseTexture2D
@export var object_seed: NoiseTexture2D

# Constants
const BASE_BLOCKS_ID = 2

const GRASS_BASE_ATLUS = Vector2i(0, 0)
const GRASS_CUT_ATLUS = Vector2i(1, 0)
const FLOWERS_ATLUS = Vector2i(2, 0)
const HIGHLIGHT_ATLUS = Vector2i(6, 0)
const SOIL_ATLUS = Vector2i(3, 0)
const BOUNDARY_ATLUS = Vector2i(0, 1)

# Variables
@onready var world_height = world_seed.height * 1.0
@onready var world_width = world_seed.width * 1.0


# The entry function
# This is the function that will be called to generate a new world
func generate_world_map(_seed: int) -> void:
	generate_base_map()
	generate_boundaries()
	generate_game_objects()


func generate_base_map():
	for x in range(-world_height/2, world_height/2):
		for y in range(-world_width/2, world_width/2):
			# noise value is between -0.5 and + 0.5
			var noise = world_seed.noise.get_noise_2d(x, y)

			if noise >= 0.25:
				WorldContext.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_BASE_ATLUS
				)
			elif noise >= 0:
				WorldContext.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_CUT_ATLUS
				)
			elif noise >= -0.25:
				WorldContext.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					FLOWERS_ATLUS
				)
			else:
				WorldContext.ground.set_cell(
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
	var used = WorldContext.ground.get_used_cells()

	for tile in used:
		for offset in offsets:
			var current_tile = tile + offset
			if WorldContext.ground.get_cell_source_id(current_tile) == -1:
				WorldContext.ground.set_cell(current_tile, BASE_BLOCKS_ID, BOUNDARY_ATLUS)

func generate_game_objects():
	for x in range(-world_height/2, world_height/2):
		for y in range(-world_width/2, world_width/2):
			var tile_position = Vector2i(x, y)
			# noise value is between -0.5 and + 0.5
			var noise = object_seed.noise.get_noise_2d(x, y)
			
			if noise > 0:
				var tile_data = WorldContext.ground.get_cell_atlas_coords(tile_position)
				if tile_data == GRASS_CUT_ATLUS:
						WorldServices.spawn_grass_at(tile_position, GrassComponent.GrassVariants.grass)
				elif tile_data == FLOWERS_ATLUS:
					WorldServices.spawn_grass_at(tile_position, GrassComponent.GrassVariants.flowers)
			elif noise > -0.05 && noise < -0.045:
				WorldServices.spawn_tree_at(tile_position, TreeComponent.TreeVariants.big_tree)
			elif noise > -0.1 && noise < -0.095:
				WorldServices.spawn_tree_at(tile_position, TreeComponent.TreeVariants.big_bush)
			elif noise > -0.25 && noise < -0.245:
				WorldServices.spawn_tree_at(tile_position, TreeComponent.TreeVariants.small_tree)
			elif noise > -0.3 && noise < -0.295:
				WorldServices.spawn_tree_at(tile_position, TreeComponent.TreeVariants.small_bush)
