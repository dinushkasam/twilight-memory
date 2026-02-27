extends InteractableInterface


@export var grass_component: GrassComponent


# Overrides
func can_interact(args: InteractionArgs) -> int:
	var is_player = args.actor is Player
	
	if not is_player:
		return InteractionType.NONE

	if args.tool == null:
		return InteractionType.BARE_HANDS
	
	var is_sickle = "sickle" in args.tool.data.tool_tags
	return InteractionType.BEST_TOOL if is_sickle else InteractionType.NONE

func interact(_action: InteractionAction):
	grass_component.hit_grass()
