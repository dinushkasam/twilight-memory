extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func build_interaction_action(actor: Node2D, tool: Item, tile: Vector2i) -> InteractionAction:
	var type: InteractionType = InteractionType.NONE
	var action: Action = Action.NONE
	
	# Check if its the player
	var is_player = actor is Player
	if not is_player:
		return InteractionAction.new(tile, actor, tool, type, action, tree_component)

	if tool == null:
		type = InteractionType.BARE_HANDS
	
	# Check tool preference for tree type
	var tool_tags = tool.data.item_tags
	type = tree_component.data.is_tool_for_tree(tool_tags) as InteractionType
	
	match type:
		InteractionType.BEST_TOOL, InteractionType.INEFFICIENT_TOOL:
			action = Action.HIT_TREE
		_:
			action = Action.NONE
	
	return InteractionAction.new(tile, actor, tool, type, action, tree_component)
