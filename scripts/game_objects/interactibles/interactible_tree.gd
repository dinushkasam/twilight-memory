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

func interact(_actor: Node2D, tool: Tool):
	var damage = tool.data.tool_power
	tree_component.hit_tree(damage)
