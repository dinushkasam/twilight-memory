extends CharacterBody2D
class_name Player

@export var animation_tree: AnimationTree
@export var player_state_machine: StateMachine
@export var player_input_component: PlayerInputComponent
@export var tool_controller: ToolController

@export var player_direction: Direction
@export var player_state: PlayerState

@export var last_facing_direction: Vector2

# World State
var world_context: WorldContext

# Config provider
var configs: ConfigProvider

# Need to call the init function to inject dependencies
func init(context: WorldContext, config_provider: ConfigProvider):
	world_context = context
	configs = config_provider
	
	# Init child dependencies 
	tool_controller.init(configs)
	player_input_component.init(world_context)
	player_state_machine.init(self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("character", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_state_machine.process_physics(delta)

func _input(event: InputEvent) -> void:
	player_input_component.process_input(event)

func _unhandled_input(event: InputEvent) -> void:
	player_state_machine.process_input(event)

func _process(delta: float) -> void:
	player_state_machine.process_frame(delta)


enum Direction {
	north,
	south,
	east,
	west,
	north_east,
	north_west,
	south_east,
	south_west,
}

enum PlayerState {
	moving,
	idle
}


func get_direction_from_vector(v: Vector2) -> Direction:
	if v == Vector2.ZERO:
		return player_direction # keep last direction when idle
	
	if v.x == 0:
		return Direction.north if v.y < 0 else Direction.south
	elif v.y == 0:
		return Direction.west if v.x < 0 else Direction.east
	elif v.x > 0 and v.y < 0:
		return Direction.north_east
	elif v.x < 0 and v.y < 0:
		return Direction.north_west
	elif v.x > 0 and v.y > 0:
		return Direction.south_east
	else:
		return Direction.south_west


func _on_world_context_tile_clicked(coords: Vector2i) -> void:
	if tool_controller.is_tool_equipped():
		tool_controller.use_tool(self, coords)
	else:
		world_context.interact(coords, self, null)
