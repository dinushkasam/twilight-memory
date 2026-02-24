extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func can_interact(actor: Node2D, tool: Tool) -> int:
	# Check if its the player
	var is_player = actor is Player
	
	if not is_player:
		return InteractionType.NONE

	if tool == null:
		return InteractionType.BARE_HANDS
	
	# Check tool preference for tree type
	var best = tree_component.data.best_tool
	var inefficient = tree_component.data.inefficient_tool
	var tool_tags = tool.data.tool_tags
	
	if best.any(func(t): return t in tool_tags):
		return InteractionType.BEST_TOOL
	
	if inefficient.any(func(t): return t in tool_tags):
		return InteractionType.INEFFICIENT_TOOL
	
	return InteractionType.NONE

func interact(actor: Node2D, tool: Tool, interaction_type: int):
	# We know that actor is a player from @can_interact()
	var player: Player = actor
	
	var base_damage = player.configs.player_config.player_base_damage
	var total_damage = 0
	
	# Directly access tool.data because tool cannot be null from @can_interact()
	if interaction_type != InteractionType.BARE_HANDS:
		base_damage += tool.data.tool_power
	
	# Check interaction type
	match interaction_type:
		InteractionType.BEST_TOOL:
			total_damage = base_damage * tree_component.data.best_tool_multiplier
		InteractionType.INEFFICIENT_TOOL:
			total_damage = base_damage * tree_component.data.inefficient_tool_multiplier
		InteractionType.BARE_HANDS:
			total_damage = base_damage * tree_component.data.bare_hands_multiplier
	
	tree_component.hit_tree(total_damage)
