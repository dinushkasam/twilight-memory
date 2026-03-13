extends Node2D
class_name GameObjectComponent


@export var parent: Node
var id: int
var tile_coords: Vector2i

@export var spawn_on_death: Dictionary = {}


func _ready():
	WorldContext.game_object_registry.register_object(self)

func _exit_tree():
	WorldContext.game_object_registry.unregister_object(self)
