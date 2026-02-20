extends Node2D
class_name Tool


var data: ToolData


func use(actor: Player, target_tile: Vector2i):
	actor.world_context.interact(target_tile, actor, self)
