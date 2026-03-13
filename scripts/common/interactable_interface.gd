extends Node
class_name InteractableInterface

@export var interaction_priority = 0
@export var parent: Node

enum InteractionType {
	NONE,
	BARE_HANDS,
	BEST_TOOL,
	INEFFICIENT_TOOL
}

enum Action {
	NONE,
	PLOW,
	PLANT_SEED,
	HIT_TREE,
	HIT_GRASS
}

class InteractionAction:
	var coords: Vector2i
	var actor: Node2D
	var tool: Item
	var interaction_type: int
	var action_type: int
	var target: Node
	
	func _init(
		coords_arg: Vector2i,
		actor_arg: Node2D,
		tool_arg: Item,
		intr_arg: InteractionType,
		action_arg: Action,
		target_arg: Node
	):
		self.coords = coords_arg
		self.actor = actor_arg
		self.tool = tool_arg
		self.interaction_type = intr_arg
		self.action_type = action_arg
		self.target = target_arg

func _ready() -> void:
	set_parent(null)
	parent.add_to_group("interactable")
	parent.set_meta("interactable", self)


# Extensible methods
func set_parent(node: Node):
	if node:
		self.parent = node
	else:
		self.parent = get_parent()

func build_interaction_action(_actor: Node2D, _tool: Item, _tile: Vector2i) -> InteractionAction:
	return null
