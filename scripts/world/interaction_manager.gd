extends Node
class_name InteractionManager

@export var ground_interactable_component: InteractableInterface


func interact_at_tile(coords: Vector2i, actor: Node2D, tool: Node2D):
	var pos = WorldContext.ground.map_to_local(coords)
	
	var space = WorldContext.get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	var results = space.intersect_point(query)
	
	var best: InteractableInterface = null
	var interact_args = InteractableInterface.InteractionArgs.new(
		coords,
		actor,
		tool
	)
	var interaction_type: int = InteractableInterface.InteractionType.NONE
	
	# First check for interactable physics objects
	for hit in results:
		var node: Node = hit.collider
		if node.is_in_group("interactable"):
			var interactable: InteractableInterface = node.get_meta("interactable", null)
			interaction_type = interactable.can_interact(interact_args)
			if interaction_type != InteractableInterface.InteractionType.NONE:
				if best == null or interactable.interaction_priority > best.interaction_priority:
					best = interactable
	
	# If no physics interactables, check for ground interactions
	if results.size() == 0 and best == null:
		interaction_type = ground_interactable_component.can_interact(interact_args)
		if interaction_type != InteractableInterface.InteractionType.NONE:
			best = ground_interactable_component
	
	if best and interaction_type != InteractableInterface.InteractionType.NONE:
		var interact_action = InteractableInterface.InteractionAction.new(
			interact_args,
			interaction_type
		)
		best.interact(interact_action)
