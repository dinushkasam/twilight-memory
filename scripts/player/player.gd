extends CharacterBody2D

@export var move_speed := 120.0
@export var acceleration := 1.0

var grid_position: Vector2i
var standing_on_ground: bool

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.dd


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_movement()
	update_grid_position()
	update_animation()
	

func handle_movement():
	var input_vector := Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	velocity = input_vector * move_speed
	move_and_slide()


func update_grid_position():
	var world := get_parent().get_parent().get_node("GroundTileMapLayer") as TileMapLayer
	var local_position := world.to_local(global_position)
	grid_position = world.local_to_map(local_position)


func update_animation():
	if velocity.length() > 0:
		pass # play walk animation
	else:
		pass # play idle animation
