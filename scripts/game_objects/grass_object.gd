extends InteractibleArea

@export var grass_variant: GrassComponent.GrassVariants

@onready var grass_component: GrassComponent = $GrassComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grass_component.set_variant(grass_variant)



func _on_body_entered(body: Node2D) -> void:
	grass_component.walking_on_tile(body)


func _on_body_exited(body: Node2D) -> void:
	grass_component.exit_tile(body)
