extends Node
class_name GameObjectManager

# Node2d holding all game objects
@export var game_objects: GameObjectRegistry
@export var crop_layer: CropRegistry

# Game object scenes
@export var tree_scene: PackedScene
@export var grass_scene: PackedScene
@export var plot_scene: PackedScene

# Tree configs
@export var small_tree_resource: TreeConfig
@export var big_tree_resource: TreeConfig
@export var small_bush_resource: TreeConfig
@export var big_bush_resource: TreeConfig

# Signals
@warning_ignore("unused_signal")
signal object_spawned(node: Node)

# Object spawn functions
func spawn_grass(coords: Vector2i, variant: GrassComponent.GrassVariants):
	var grass = grass_scene.instantiate()
	var position = WorldContext.ground.map_to_local(coords)
	grass.set("position", position)
	grass.set("grass_variant", variant)
	
	var gmc: GameObjectComponent = grass.get_node("GameObjectComponent")
	gmc.tile_coords = coords
	game_objects.add_child(grass)

func spawn_tree(coords: Vector2i, variant: TreeComponent.TreeVariants):
	var tree = tree_scene.instantiate()
	var config = map_tree_variant_config(variant)
	var position = WorldContext.ground.map_to_local(coords)
	tree.set("position", position)
	tree.set("tree_variant", config)
	
	var gmc: GameObjectComponent = tree.get_node("GameObjectComponent")
	gmc.tile_coords = coords
	game_objects.add_child(tree)

func spawn_plot(coords: Vector2i):
	var plot = plot_scene.instantiate()
	var position = WorldContext.ground.map_to_local(coords)
	plot.set("position", position)
	
	var gmc: GameObjectComponent = plot.get_node("GameObjectComponent")
	gmc.tile_coords = coords
	game_objects.add_child(plot)

func spawn_entity(entity: Node2D, coords: Vector2i):
	var position = WorldContext.ground.map_to_local(coords)
	entity.set("position", position)
	
	var gmc: GameObjectComponent = entity.get_node("GameObjectComponent")
	if gmc:
		gmc.tile_coords = coords
	
	game_objects.add_child(entity)

func spawn_crop(crop: Crop, coords: Vector2i):
	var position = WorldContext.ground.map_to_local(coords)
	crop.set("position", position)
	
	var gmc: GameObjectComponent = crop.get_node("GameObjectComponent")
	gmc.tile_coords = coords
	crop_layer.add_child(crop)


# Helper function
func map_tree_variant_config(variant: TreeComponent.TreeVariants) -> TreeConfig:
	match  variant:
		TreeComponent.TreeVariants.small_tree:
			return small_tree_resource
		TreeComponent.TreeVariants.big_tree:
			return big_tree_resource
		TreeComponent.TreeVariants.small_bush:
			return small_bush_resource
		TreeComponent.TreeVariants.big_bush:
			return big_bush_resource
		_:
			return null
