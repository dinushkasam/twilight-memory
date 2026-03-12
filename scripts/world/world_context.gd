extends Node2D

# Global states
var ground: TileMapLayer
var highlight: TileMapLayer
var game_object_manager: GameObjectManager
var highlighted_cell: Vector2i
var interaction_manager: InteractionManager
var game_object_registry: GameObjectRegistry
var crop_registry: CropRegistry



func init(world: Node):
	ground = world.get_node("GroundTileMapLayer")
	game_object_manager = world.get_node("GameObjectManager")
	highlight = world.get_node("GroundHighlightTileMapLayer")
	interaction_manager = world.get_node("InteractionManager")
	game_object_registry = world.get_node("GameObjectRegistry")
	crop_registry = world.get_node("CropRegistry")


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
		coords,
		variant
	)

func spawn_tree(coords: Vector2i, variant: TreeComponent.TreeVariants):
	game_object_manager.spawn_tree(
		coords,
		variant
	)

func spawn_entity(entity: Node2D, coords: Vector2i):
	game_object_manager.spawn_entity(
		entity,
		coords
	)

func spawn_crop(crop: Crop, coords: Vector2i):
	game_object_manager.spawn_crop(
		crop,
		coords
	)

func spawn_plot(coords: Vector2i):
	game_object_manager.spawn_plot(coords)


# Interaction Manager
func interact(coords: Vector2i, actor: Node2D, tool: Node2D):
	interaction_manager.interact_at_tile(coords, actor, tool)
