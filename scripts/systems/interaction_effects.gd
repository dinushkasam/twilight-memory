extends Node
class_name InteractionEffects


func apply(action: InteractableInterface.InteractionAction):
	match action.action_type:
		InteractableInterface.Action.HIT_TREE:
			_apply_tree_hit(action)
		InteractableInterface.Action.PLANT_SEED:
			_apply_plant_seed(action)
		InteractableInterface.Action.PLOW:
			_apply_plow_soil(action)
		InteractableInterface.Action.HIT_GRASS:
			_apply_grass_hit(action)
		_:
			return


# Internals
# Damage appliers
func _apply_tree_hit(action: InteractableInterface.InteractionAction):
	var base_damage = ConfigProvider.player_config.player_base_damage
	var total_damage = 0
	
	if action.action_type == InteractableInterface.Action.NONE:
		return
	
	# Directly access action.tool because tool cannot be null from previous checks
	var item_data = action.tool.get_data()
	if item_data is ToolData:
		var tool_data: ToolData = item_data as ToolData
		base_damage += tool_data.tool_power
	
	if not action.target is TreeComponent:
		printerr("[Tree hit error]: target is not a tree component")
		return
	
	var tree_component: TreeComponent = action.target
	var multiplier = tree_component.data.get_damage_multiplier(action.interaction_type)
	if multiplier == -1:
		printerr("Unsupported interaction type on tree object")
	
	total_damage = base_damage * multiplier
	
	tree_component.hit_tree(total_damage)

func _apply_grass_hit(action: InteractableInterface.InteractionAction):
	if not action.target is GrassComponent:
		printerr("[Grass hit error]: target is not a grass component")
		return
		
	var grass_component: GrassComponent = action.target
	grass_component.hit_grass()

# Entity spawners
func _apply_plant_seed(action: InteractableInterface.InteractionAction):
	# Directly access action.tool because tool cannot be null from previous checks
	var item_data = action.tool.get_data()
	if item_data == null:
		printerr("Item data is null for -> ", action.tool.data.item_name)
		return
	
	var crop_data = item_data.get_crop_data_arg()
	if crop_data == null:
		return
	
	var crop_scene: PackedScene = item_data.get_spawn_entity()
	if crop_scene == null:
		return
	
	var crop: Crop = crop_scene.instantiate()
	
	WorldServices.spawn_crop_at(crop, action.coords, crop_data)

func _apply_plow_soil(action: InteractableInterface.InteractionAction):
	WorldServices.spawn_plot_at(action.coords)
