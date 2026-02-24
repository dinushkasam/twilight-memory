extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func can_interact(actor: Node2D, tool: Tool) -> bool:
	# Check if its the player
	var is_player = actor is Player
	
	if is_player:
		# Check tool preference for tree type
		var best = tree_component.data.best_tool
		var inefficient = tree_component.data.inefficient_tool
		var tool_tags = tool.data.tool_tags
		
		var is_best = best.any(func(t): return t in tool_tags)
		
		if is_best:
			return true
		
		var is_inefficient = inefficient.any(func(t): return t in tool_tags)
		
		return true if is_inefficient else false
	else:
		return false

func interact(actor: Node2D, tool: Tool):
	var base_damage = tool.data.tool_power
	var total_damage = 0
	# We know that actor is a player from @can_interact function
	var player: Player = actor
	
	# Check tool preference for tree type
	var best = tree_component.data.best_tool
	var tool_tags = tool.data.tool_tags
	
	var is_best = best.any(func(t): return t in tool_tags)
	
	if is_best:
		total_damage = base_damage * player.configs.player_config.best_tool_multiplier
	else:
		total_damage = base_damage * player.configs.player_config.inefficient_tool_multiplier
	
	tree_component.hit_tree(total_damage)
