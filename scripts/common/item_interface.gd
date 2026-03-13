extends Resource
class_name ItemData

@export var item_name: String
@export var animation: String
@export var item_scene: PackedScene
@export var item_tags: Array[String]

@export var consumable = false

@export var spawn_entity: PackedScene = null
@export var spawn_args: Dictionary
