extends Node
class_name WorldGeneratorCOmponent

# World State
var world_context: WorldContext

@export var world_seed: NoiseTexture2D
@export var object_seed: NoiseTexture2D

@export var tree_scene: PackedScene
@export var grass_scene: PackedScene

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

# Need to call the init function to inject dependencies
func init(context: WorldContext):
	world_context = context

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
				world_context.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_BASE_ATLUS
				)
			elif noise >= 0:
				world_context.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					GRASS_CUT_ATLUS
				)
			elif noise >= -0.25:
				world_context.ground.set_cell(
					Vector2i(x, y),
					BASE_BLOCKS_ID,
					FLOWERS_ATLUS
				)
			else:
				world_context.ground.set_cell(
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
	var used = world_context.ground.get_used_cells()

	for tile in used:
		for offset in offsets:
			var current_tile = tile + offset
			if world_context.ground.get_cell_source_id(current_tile) == -1:
				world_context.ground.set_cell(current_tile, BASE_BLOCKS_ID, BOUNDARY_ATLUS)

func generate_game_objects():
	for x in range(-world_height/2, world_height/2):
		for y in range(-world_width/2, world_width/2):
			var tile_position = Vector2i(x, y)
			# noise value is between -0.5 and + 0.5
			var noise = object_seed.noise.get_noise_2d(x, y)
			
			if noise > 0:
				var tile_data = world_context.ground.get_cell_atlas_coords(tile_position)
				if tile_data == GRASS_CUT_ATLUS:
						spawn_grass(tile_position, GrassComponent.GrassVariants.grass)
				elif tile_data == FLOWERS_ATLUS:
					spawn_grass(tile_position, GrassComponent.GrassVariants.flowers)
			elif noise > -0.05 && noise < -0.045:
				spawn_tree(tile_position, TreeComponent.TreeVariants.big_tree)
			elif noise > -0.1 && noise < -0.095:
				spawn_tree(tile_position, TreeComponent.TreeVariants.big_bush)
			elif noise > -0.25 && noise < -0.245:
				spawn_tree(tile_position, TreeComponent.TreeVariants.small_tree)
			elif noise > -0.3 && noise < -0.295:
				spawn_tree(tile_position, TreeComponent.TreeVariants.small_bush)


# Helper functions
func spawn_grass(coords: Vector2i, variant: GrassComponent.GrassVariants):
	var grass = grass_scene.instantiate()
	grass.set("position", world_context.ground.map_to_local(coords))
	grass.set("grass_variant", variant)
	world_context.game_objects.add_child(grass)

func spawn_tree(coords: Vector2i, variant: TreeComponent.TreeVariants):
	var tree = tree_scene.instantiate()
	tree.set("position", world_context.ground.map_to_local(coords))
	tree.set("tree_variant", variant)
	world_context.game_objects.add_child(tree)
