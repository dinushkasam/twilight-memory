extends Node
class_name TreeComponent

@export var sprite: AnimatedSprite2D

@export var allow_pass_through := false
@export var can_be_cut := false
@export var health := 3

enum TreeVariants {
	small_tree,
	big_tree,
	small_bush,
	big_bush
}

signal tree_died

func set_variant(variation: TreeVariants):
	match variation:
		TreeVariants.small_tree:
			sprite.play("small_tree")
		TreeVariants.big_tree:
			sprite.play("big_tree")
		TreeVariants.small_bush:
			sprite.play("small_bush")
		TreeVariants.big_bush:
			sprite.play("big_bush")

func hit_tree(damage: int):
	health -= damage
	if health <= 0:
		tree_died.emit()
