extends Node2D
class_name CropRegistry


var crop_by_tile := {}
var next_id: int = 1



func register_crop(obj: GameObjectComponent):
	obj.id = next_id
	next_id += 1

	var tile = obj.tile_coords
	if tile not in crop_by_tile:
		crop_by_tile[tile] = obj

func unregister_crop(obj: GameObjectComponent):
	crop_by_tile.erase(obj.tile_coords)

func get_crops_at(tile: Vector2i):
	if tile in crop_by_tile:
		return crop_by_tile[tile]
	
	return null
