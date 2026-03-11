extends Node
class_name GameObjectManager

# Node2d holding all game objects
@export var game_objects: Node2D
@export var crop_layer: Node2D

# Game object scenes
@export var tree_scene: PackedScene
@export var grass_scene: PackedScene
@export var plot_scene: PackedScene

# Tree configs
@export var small_tree_resource: TreeConfig
@export var big_tree_resource: TreeConfig
@export var small_bush_resource: TreeConfig
@export var big_bush_resource: TreeConfig


# Object spawn functions
func spawn_grass(position: Vector2, variant: GrassComponent.GrassVariants):
	var grass = grass_scene.instantiate()
	grass.set("position", position)
	grass.set("grass_variant", variant)
	game_objects.add_child(grass)

func spawn_tree(position: Vector2, variant: TreeComponent.TreeVariants):
	var tree = tree_scene.instantiate()
	var config = map_tree_variant_config(variant)
	tree.set("position", position)
	tree.set("tree_variant", config)
	game_objects.add_child(tree)

func spawn_plot(position: Vector2):
	var plot = plot_scene.instantiate()
	plot.set("position", position)
	game_objects.add_child(plot)

func spawn_entity(entity: Node2D, position: Vector2):
	entity.set("position", position)
	game_objects.add_child(entity)

func spawn_crop(crop: Crop, position: Vector2):
	crop.set("position", position)
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
