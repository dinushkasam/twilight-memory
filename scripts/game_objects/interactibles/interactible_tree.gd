extends InteractableInterface


@export var tree_component: TreeComponent


# Overrides
func can_interact(actor: Node2D, tool: Tool) -> bool:
	var is_player = actor is Player
	var is_axe = tool is AxeTool
	
	return true if is_player and is_axe else false

func interact(_actor: Node2D, tool: Tool):
	var damage = tool.data.tool_power
	tree_component.hit_tree(damage)
