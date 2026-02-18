extends StaticBody2D
class_name InteractibleStaticBody


# Extensible methods
func can_interact(_actor: Node2D, _tool: Node2D) -> bool:
	return true

func interact(_actor: Node2D, _tool: Node2D):
	pass
