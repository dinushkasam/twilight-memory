extends Node
class_name GrassComponent

@export var sprite: AnimatedSprite2D
@export var collision: CollisionPolygon2D

enum GrassVariants {
	flowers,
	grass,
	grass_rustle
}

func set_variant(variation: GrassVariants):
	match variation:
		GrassVariants.flowers:
			sprite.play("flowers")
		GrassVariants.grass:
			sprite.play("grass")
		GrassVariants.grass_rustle:
			sprite.play("grass_rustle")

func walking_on_tile(body: Node2D):
	if body.is_in_group("character") && sprite.animation == "grass":
		sprite.play("grass_rustle")

func exit_tile(body: Node2D):
	if body.is_in_group("character") && sprite.animation == "grass_rustle":
		sprite.play("grass")
