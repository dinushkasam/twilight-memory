extends Node
class_name InteractableInterface

@export var interaction_priority = 0
@export var parent: Node

func _ready() -> void:
	parent.add_to_group("interactable")
	parent.set_meta("interactable", self)

# Extensible methods
func can_interact(_actor: Node2D, _tool: Node2D) -> bool:
	return true

func interact(_actor: Node2D, _tool: Node2D):
	pass
