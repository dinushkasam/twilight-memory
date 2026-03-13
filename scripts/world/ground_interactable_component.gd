extends InteractableInterface

@export var ground_tile_map_layer: TileMapLayer
@export var game_object_manager: GameObjectManager

var allowed_sources = [2]
var allowed_atluses = [
	Vector2i(0,0),
	Vector2i(1,0),
	Vector2i(2,0),
	Vector2i(3,0)
]

# Extensible methods
func build_interaction_action(actor: Node2D, tool: Item, tile: Vector2i) -> InteractionAction:
	var action: InteractionAction = InteractionAction.new(
		tile,
		actor,
		tool,
		InteractionType.NONE,
		Action.NONE,
		self
	)
	
	if not actor is Player:
		return action
	
	var source = ground_tile_map_layer.get_cell_source_id(tile)
	if not source in allowed_sources:
		return action
	
	var atlus = ground_tile_map_layer.get_cell_atlas_coords(tile)
	if not atlus in allowed_atluses:
		return action
	
	if tool == null:
		action.interaction_type = InteractionType.BARE_HANDS
		return action
	
	if tool.data.is_hoe():
		action.action_type = Action.PLOW
	
	return action
