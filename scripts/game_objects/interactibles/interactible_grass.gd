extends InteractableInterface


@export var grass_component: GrassComponent


# Overrides
func can_interact(actor: Node2D, tool: Tool) -> int:
	var is_player = actor is Player
	
	if not is_player:
		return InteractionType.NONE

	if tool == null:
		return InteractionType.BARE_HANDS
	
	var is_sickle = "sickle" in tool.data.tool_tags
	return InteractionType.BEST_TOOL if is_sickle else InteractionType.NONE

func interact(_actor: Node2D, _tool: Tool, _interaction_type: int):
	grass_component.hit_grass()
