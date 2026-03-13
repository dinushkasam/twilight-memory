extends Resource
class_name ItemData

@export var item_name: String
@export var animation: String
@export var item_scene: PackedScene
@export var item_tags: Array[String]

@export var consumable = false

@export var spawn_entity: PackedScene = null
@export var spawn_args: Dictionary


# Helpers
func has_tag(tag: String) -> bool:
	return tag in item_tags

func is_seed() -> bool:
	return "seed" in item_tags

func is_sickle() -> bool:
	return "sickle" in item_tags

func is_hoe() -> bool:
	return "hoe" in item_tags

func get_crop_data_arg() -> CropData:
	var data = spawn_args["crop_type"]
	
	if data == null:
		printerr("crop_type spawn arg is not set for -> ", item_name)
		return null
	
	if not data is CropData:
		printerr("crop_type spawn arg is not of type `CropData`")
		return null
	
	return data as CropData

func get_spawn_entity() -> PackedScene:
	if not spawn_entity:
		printerr("Spawn entity scene not set for -> ", item_name)
		return null
	
	return spawn_entity
