extends Node2D
class_name GameObjectRegistry


var objects: Dictionary[int, GameObjectComponent] = {}
var objects_by_tile: Dictionary = {}
var next_id: int = 1


func register_object(obj: GameObjectComponent):
	obj.id = next_id
	next_id += 1
	
	objects[obj.id] = obj

	var tile = obj.tile_coords
	if tile not in objects_by_tile:
		objects_by_tile[tile] = [] as Array[GameObjectComponent]

	objects_by_tile[tile].append(obj)

func unregister_object(obj: GameObjectComponent):
	objects.erase(obj.id)

	var tile = obj.tile_coords
	objects_by_tile[tile].erase(obj)

func get_objects_at(tile: Vector2i) -> Array[GameObjectComponent]:
	if tile in objects_by_tile:
		return objects_by_tile[tile]

	return []
