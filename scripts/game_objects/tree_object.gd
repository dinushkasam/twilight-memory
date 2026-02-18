extends InteractibleStaticBody


@export var tree_variant: TreeComponent.TreeVariants
@export var tree_component: TreeComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TreeComponent.set_variant(tree_variant)


# Overrides
func can_interact(actor: Node2D, _tool: Node2D) -> bool:
	return true if actor is Player else false

func interact(_actor: Node2D, _tool: Node2D):
	var damage = 1
	tree_component.hit_tree(damage)


# Signal processing
func _on_tree_component_tree_died() -> void:
	queue_free()
