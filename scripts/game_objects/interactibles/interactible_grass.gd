extends InteractableInterface


@export var grass_component: GrassComponent


# Overrides
func can_interact(actor: Node2D, tool: Tool) -> bool:
	var is_player = actor is Player
	var is_sickle = "sickle" in tool.data.tool_tags
	
	return true if is_player and is_sickle else false

func interact(_actor: Node2D, _tool: Tool):
	grass_component.hit_grass()
