extends InteractableInterface


# Extensible methods
func can_interact(args: InteractionArgs) -> int:
	# Check if its the player
	var is_player = args.actor is Player
	
	if not is_player:
		return InteractionType.NONE

	if args.tool == null:
		return InteractionType.BARE_HANDS
	
	# Check if it is a seed
	var tool_tags = args.tool.data.item_tags
	
	if "seed" in tool_tags:
		return InteractionType.PLANT_SEED
	
	return InteractionType.NONE

func interact(action: InteractionAction):
	match action.interaction_type:
		InteractionType.PLANT_SEED:
			var tool_data = action.args.tool.data
			var crop_data: CropData = tool_data.spawn_args.get("crop_type")
			var crop_scene: PackedScene = tool_data.spawn_entity
			
			var crop: Crop = crop_scene.instantiate()
			
			WorldServices.spawn_crop_at(crop, action.args.coords, crop_data)
		_:
			return
