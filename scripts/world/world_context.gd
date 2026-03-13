extends Node2D
class_name ContextProvider

# Global states
var ground: TileMapLayer
var highlight: TileMapLayer
var highlighted_cell: Vector2i
var game_object_registry: GameObjectRegistry
var crop_registry: CropRegistry


func init(
	ground_arg: TileMapLayer,
	highlight_arg: TileMapLayer,
	gm_reg: GameObjectRegistry,
	crop_reg: CropRegistry
):
	ground = ground_arg
	highlight = highlight_arg
	game_object_registry = gm_reg
	crop_registry = crop_reg


# Tile Management
func get_hovered_cell() -> Vector2i:
	var mouse_position := get_global_mouse_position()
	var local_position := ground.to_local(mouse_position)
	var cell := ground.local_to_map(local_position)
	return cell

func get_grid_position(node: Node2D) -> Vector2i:
	var local_position := ground.to_local(node.global_position)
	var grid_position = ground.local_to_map(local_position)
	return grid_position

func coords_to_pos(coords: Vector2i) -> Vector2:
	return ground.map_to_local(coords)

# Object Registries
func get_crop_at_tile(coords: Vector2i) -> GameObjectComponent:
	return crop_registry.get_crop_at(coords)
