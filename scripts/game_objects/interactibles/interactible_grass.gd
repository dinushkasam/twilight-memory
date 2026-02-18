extends InteractableInterface


@export var grass_component: GrassComponent


# Overrides
func can_interact(actor: Node2D, _tool: Node2D) -> bool:
	return true if actor is Player else false

func interact(_actor: Node2D, _tool: Node2D):
	grass_component.hit_grass()
