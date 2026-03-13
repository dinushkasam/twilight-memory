extends Resource
class_name TreeConfig

@export var animation_name: String
@export var max_health: int
@export var best_tool: Array[String]
@export var inefficient_tool: Array[String]

@export var best_tool_multiplier := 2.0
@export var inefficient_tool_multiplier := 0.5
@export var bare_hands_multiplier := 0.0


# Helpers
func is_tool_for_tree(tags: Array[String]) -> int:
	if tags.any(func(t): return t in best_tool):
		return InteractableInterface.InteractionType.BEST_TOOL
	
	if tags.any(func(t): return t in inefficient_tool):
		return InteractableInterface.InteractionType.INEFFICIENT_TOOL
	
	return InteractableInterface.InteractionType.NONE

## returns -1 for invalid entries
func get_damage_multiplier(type: InteractableInterface.InteractionType) -> float:
	match type:
		InteractableInterface.InteractionType.BEST_TOOL:
			return best_tool_multiplier
		InteractableInterface.InteractionType.INEFFICIENT_TOOL:
			return inefficient_tool_multiplier
		InteractableInterface.InteractionType.BARE_HANDS:
			return bare_hands_multiplier
		_:
			return -1
