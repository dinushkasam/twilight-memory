extends Node
class_name GameObjectManager

# Node2d holding all game objects
var game_objects: Node2D

# Game object scenes
@export var tree_scene: PackedScene
@export var grass_scene: PackedScene

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
	tree.set("position", position)
	tree.set("tree_variant", variant)
	game_objects.add_child(tree)
