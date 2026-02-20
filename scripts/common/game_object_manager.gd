extends Node
class_name GameObjectManager

# Node2d holding all game objects
var game_objects: Node2D

# Game object scenes
@export var tree_scene: PackedScene
@export var grass_scene: PackedScene

# Tree configs
@export var small_tree_resource: TreeConfig
@export var big_tree_resource: TreeConfig
@export var small_bush_resource: TreeConfig
@export var big_bush_resource: TreeConfig

# Need to initialize the manager
func init(node: Node2D):
	game_objects = node


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
