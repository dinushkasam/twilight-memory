extends Node2D

# Global states
var ground: TileMapLayer
var highlight: TileMapLayer
var game_object_manager: GameObjectManager
var highlighted_cell: Vector2i
var interaction_manager: InteractionManager


func init(
	ground_arg: TileMapLayer,
	game_obj_mgr_arg: GameObjectManager,
	highlight_arg: TileMapLayer,
	interaction_mgr_arg: InteractionManager
):
	ground = ground_arg
	game_object_manager = game_obj_mgr_arg
	highlight = highlight_arg
	interaction_manager = interaction_mgr_arg


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


# Object Manager
func spawn_grass(coords: Vector2i, variant: GrassComponent.GrassVariants):
	game_object_manager.spawn_grass(
		ground.map_to_local(coords),
		variant
	)

func spawn_tree(coords: Vector2i, variant: TreeComponent.TreeVariants):
	game_object_manager.spawn_tree(
		ground.map_to_local(coords),
		variant
	)


# Interaction Manager
func interact(coords: Vector2i, actor: Node2D, tool: Node2D):
	interaction_manager.interact_at_tile(coords, actor, tool)
