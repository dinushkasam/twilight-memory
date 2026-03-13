extends Node
class_name InteractionManager


@export var ground_interactable_component: InteractableInterface
var interaction_effects: InteractionEffects


func _ready() -> void:
	interaction_effects = InteractionEffects.new()


func interact_at_tile(coords: Vector2i, actor: Node2D, tool: Node2D):
	var results: Array[GameObjectComponent] = WorldContext.game_object_registry.get_objects_at(coords)
	
	var best: InteractableInterface = null
	var action: InteractableInterface.InteractionAction
	
	# First check for interactable objects
	for hit in results:
		var node: Node = hit.parent
		if node.is_in_group("interactable"):
			var interactable: InteractableInterface = node.get_meta("interactable", null)
			if best == null or interactable.interaction_priority > best.interaction_priority:
				best = interactable
				action = interactable.build_interaction_action(actor, tool, coords)
	
	# If no interactables, check for ground interactions
	if results.size() == 0 and best == null:
		best = ground_interactable_component
		action = ground_interactable_component.build_interaction_action(actor, tool, coords)
	
	if best:
		interaction_effects.apply(action)
