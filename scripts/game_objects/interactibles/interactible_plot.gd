extends InteractableInterface


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
	
	# Check if its the player
	var is_player = actor is Player
	if not is_player:
		return action

	if tool == null:
		action.interaction_type = InteractionType.BARE_HANDS
		return action
	
	# Check if it is a seed
	if tool.data.is_seed():
		action.action_type = Action.PLANT_SEED
	
	return action
