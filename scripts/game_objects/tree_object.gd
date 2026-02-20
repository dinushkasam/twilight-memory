extends StaticBody2D


@export var tree_variant: TreeConfig
@export var tree_component: TreeComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TreeComponent.set_variant(tree_variant)


# Signal processing
func _on_tree_component_tree_died() -> void:
	queue_free()
