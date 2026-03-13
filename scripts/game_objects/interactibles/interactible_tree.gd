extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func can_interact(args: InteractionArgs) -> int:
	# Check if its the player
	var is_player = args.actor is Player
	
	if not is_player:
		return InteractionType.NONE

	if args.tool == null:
		return InteractionType.BARE_HANDS
	
	# Check tool preference for tree type
	var best = tree_component.data.best_tool
	var inefficient = tree_component.data.inefficient_tool
	var tool_tags = args.tool.data.item_tags
	
	if best.any(func(t): return t in tool_tags):
		return InteractionType.BEST_TOOL
	
	if inefficient.any(func(t): return t in tool_tags):
		return InteractionType.INEFFICIENT_TOOL
	
	return InteractionType.NONE

func interact(action: InteractionAction):
	var base_damage = ConfigProvider.player_config.player_base_damage
	var total_damage = 0
	
	# Directly access tool.data because tool cannot be null from @can_interact()
	if action.interaction_type != InteractionType.BARE_HANDS:
		base_damage += action.args.tool.data.tool_power
	
	# Check interaction type
	match action.interaction_type:
		InteractionType.BEST_TOOL:
			total_damage = base_damage * tree_component.data.best_tool_multiplier
		InteractionType.INEFFICIENT_TOOL:
			total_damage = base_damage * tree_component.data.inefficient_tool_multiplier
		InteractionType.BARE_HANDS:
			total_damage = base_damage * tree_component.data.bare_hands_multiplier
		_:
			return
	
	tree_component.hit_tree(total_damage)
