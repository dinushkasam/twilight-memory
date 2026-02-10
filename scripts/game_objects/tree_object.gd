extends StaticBody2D


@export var tree_variant: TreeComponent.TreeVariants

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TreeComponent.set_variant(tree_variant)
