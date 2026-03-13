extends Node2D


var game_object_manager: GameObjectManager
var interaction_manager: InteractionManager


func init(
	gm_obj_mgr: GameObjectManager,
	intr_mgr: InteractionManager,
):
	game_object_manager = gm_obj_mgr
	interaction_manager = intr_mgr


# Object Manager
func spawn_grass_at(coords: Vector2i, variant: GrassComponent.GrassVariants):
	game_object_manager.spawn_grass(
		coords,
		variant
	)

func spawn_tree_at(coords: Vector2i, variant: TreeComponent.TreeVariants):
	game_object_manager.spawn_tree(
		coords,
		variant
	)

func spawn_entity_at(entity: Node2D, coords: Vector2i):
	game_object_manager.spawn_entity(
		entity,
		coords
	)

func spawn_crop_at(crop: Crop, coords: Vector2i, crop_data: CropData):
	game_object_manager.spawn_crop(
		crop,
		coords,
		crop_data
	)

func spawn_plot_at(coords: Vector2i):
	game_object_manager.spawn_plot(coords)


# Interaction Manager
func interact_at_tile(coords: Vector2i, actor: Node2D, tool: Node2D):
	interaction_manager.interact_at_tile(coords, actor, tool)
