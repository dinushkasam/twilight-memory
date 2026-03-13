extends InteractableInterface


@export var grass_component: GrassComponent


# Overrides
func build_interaction_action(actor: Node2D, tool: Item, tile: Vector2i) -> InteractionAction:
	var action: InteractionAction = InteractionAction.new(
		tile,
		actor,
		tool,
		InteractionType.NONE,
		Action.NONE,
		grass_component
	)
	
	var is_player = actor is Player
	if not is_player:
		return action

	if tool == null:
		action.interaction_type = InteractionType.BARE_HANDS
		return action
	
	var is_sickle = tool.data.is_sickle()
	if is_sickle:
		action.action_type = Action.HIT_GRASS
	
	return action
