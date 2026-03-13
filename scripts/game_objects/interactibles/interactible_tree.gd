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
	var tool_tags = args.tool.data.item_tags
	
	return tree_component.data.is_tool_for_tree(tool_tags)

func interact(action: InteractionAction):
	var base_damage = ConfigProvider.player_config.player_base_damage
	var total_damage = 0
	
	# Directly access tool.data because tool cannot be null from @can_interact()
	if action.interaction_type != InteractionType.BARE_HANDS:
		var item_data = action.args.tool.get_data()
		if item_data is ToolData:
			var tool_data: ToolData = item_data as ToolData
			base_damage += tool_data.tool_power
	
	var multiplier = tree_component.data.get_damage_multiplier(action.interaction_type)
	if multiplier == -1:
		printerr("Unsupported interaction type on tree object")
	
	total_damage = base_damage * multiplier
	
	tree_component.hit_tree(total_damage)
