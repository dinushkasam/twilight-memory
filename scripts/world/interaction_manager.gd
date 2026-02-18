extends Node
class_name InteractionManager

var world: WorldContext


func interact_at_tile(coords: Vector2i, actor: Node2D, tool: Node2D):
	var pos = world.ground.map_to_local(coords)
	
	var space = world.get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	var results = space.intersect_point(query)
	
	var best: InteractableInterface = null
	
	for hit in results:
		var node: Node = hit.collider
		if node.is_in_group("interactable"):
			var interactable: InteractableInterface = node.get_meta("interactable", null)
			if interactable.can_interact(actor, tool):
				if best == null or interactable.interaction_priority > best.interaction_priority:
					best = interactable
	
	if best:
		best.interact(actor, tool)
