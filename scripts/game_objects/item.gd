extends Node2D
class_name Item


var data: ItemData


func use(actor: Player, target_tile: Vector2i):
	WorldServices.interact_at_tile(target_tile, actor, self)

func get_data():
	return data as ItemData
