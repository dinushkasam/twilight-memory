extends Node
class_name TreeComponent

@export var sprite: AnimatedSprite2D
@export var health_component: HealthComponent

var data: TreeConfig

enum TreeVariants {
	small_tree,
	big_tree,
	small_bush,
	big_bush
}

signal tree_died

func set_variant(config: TreeConfig):
	data = config
	health_component.current_health = data.max_health
	sprite.play(data.animation_name)

func hit_tree(damage: int):
	health_component.do_damage(damage)
	if health_component.is_dead():
		tree_died.emit()
