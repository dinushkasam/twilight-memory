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
func can_interact(args: InteractionArgs) -> int:
	if not args.actor is Player:
		return InteractionType.NONE
	
	var source = ground_tile_map_layer.get_cell_source_id(args.coords)
	if not source in allowed_sources:
		return InteractionType.NONE
	
	var atlus = ground_tile_map_layer.get_cell_atlas_coords(args.coords)
	if not atlus in allowed_atluses:
		return InteractionType.NONE
	
	if args.tool == null:
		return InteractionType.BARE_HANDS
	
	if args.tool.data.is_hoe():
		return InteractionType.PLOW
	
	return InteractionType.NONE

func interact(action: InteractionAction):
	match action.interaction_type:
		InteractionType.PLOW:
			WorldServices.spawn_plot_at(action.args.coords)
		_:
			return
			
