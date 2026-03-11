extends Node
class_name InteractableInterface

@export var interaction_priority = 0
@export var parent: Node

enum InteractionType {
	NONE,
	BARE_HANDS,
	BEST_TOOL,
	INEFFICIENT_TOOL,
	PLOW,
	PLANT_SEED
}

class InteractionArgs:
	var coords: Vector2i
	var actor: Node2D
	var tool: Tool
	
	func _init(coords_arg: Vector2i, actor_arg: Node2D, tool_arg: Tool):
		self.coords = coords_arg
		self.actor = actor_arg
		self.tool = tool_arg

class InteractionAction:
	var args: InteractionArgs
	var interaction_type: int
	
	func _init(itr_args: InteractionArgs, type: InteractionType):
		self.args = itr_args
		self.interaction_type = type

func _ready() -> void:
	parent.add_to_group("interactable")
	parent.set_meta("interactable", self)


# Extensible methods
func can_interact(_args: InteractionArgs) -> int:
	return InteractionType.NONE

func interact(_action: InteractionAction):
	pass
