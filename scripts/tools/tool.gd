extends Node2D
class_name Tool


var data: Item


func use(actor: Player, target_tile: Vector2i):
	WorldServices.interact_at_tile(target_tile, actor, self)
