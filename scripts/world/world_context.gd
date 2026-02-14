extends Node2D
class_name WorldContext

# Global states
var ground: TileMapLayer
var highlight: TileMapLayer
var game_objects: Node2D
var highlighted_cell: Vector2i

# Signals
@warning_ignore("unused_signal")
signal tile_clicked(coords: Vector2i)
@warning_ignore("unused_signal")
signal object_spawned(node: Node)

func init(ground_arg: TileMapLayer, game_objects_arg: Node2D, highlight_arg: TileMapLayer):
	ground = ground_arg
	game_objects = game_objects_arg
	highlight = highlight_arg

func get_hovered_cell() -> Vector2i:
	var mouse_position := get_global_mouse_position()
	var local_position := ground.to_local(mouse_position)
	var cell := ground.local_to_map(local_position)
	return cell
