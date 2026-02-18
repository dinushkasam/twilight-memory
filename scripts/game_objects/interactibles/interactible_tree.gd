extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func can_interact(actor: Node2D, _tool: Node2D) -> bool:
	return true if actor is Player else false

func interact(_actor: Node2D, _tool: Node2D):
	var damage = 1
	tree_component.hit_tree(damage)
