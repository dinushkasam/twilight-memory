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

func _ready() -> void:
	parent.add_to_group("interactable")
	parent.set_meta("interactable", self)

# Extensible methods
func can_interact(_actor: Node2D, _tool: Tool) -> int:
	return InteractionType.NONE

func interact(_actor: Node2D, _tool: Tool, _interaction_type: int):
	pass
