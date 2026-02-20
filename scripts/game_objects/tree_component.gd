extends Node
class_name TreeComponent

@export var sprite: AnimatedSprite2D

var data: TreeConfig
var current_health: int

enum TreeVariants {
	small_tree,
	big_tree,
	small_bush,
	big_bush
}

signal tree_died

func set_variant(config: TreeConfig):
	data = config
	current_health = data.max_health
	sprite.play(data.animation_name)

func hit_tree(damage: int):
	current_health -= damage
	if current_health <= 0:
		tree_died.emit()
