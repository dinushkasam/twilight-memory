extends Area2D

@export var grass_variant: GrassComponent.GrassVariants

@export var grass_component: GrassComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grass_component.set_variant(grass_variant)


# Signal processing
func _on_body_entered(body: Node2D) -> void:
	grass_component.walking_on_tile(body)


func _on_body_exited(body: Node2D) -> void:
	grass_component.exit_tile(body)


func _on_grass_component_grass_died() -> void:
	queue_free()
