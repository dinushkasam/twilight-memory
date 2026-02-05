extends CharacterBody2D

@export var animation_tree: AnimationTree
@onready var player_state_machine: StateMachine = $PlayerStateMachine

@export var move_speed := 120.0
@export var acceleration := 1.0
@export var tile_aspect := Vector2(1, 1)

var up: float
var down: float
var left: float
var right: float

@export var grid_position: Vector2i

@export var player_direction: Direction
@export var player_state: PlayerState

@export var last_facing_direction: Vector2
var animation_vector: Vector2

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_state_machine.init(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_input()
	update_grid_position()
	player_state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	player_state_machine.process_input(event)

func _process(delta: float) -> void:
	player_state_machine.process_frame(delta)

func update_grid_position():
	var world := get_parent().get_parent().get_node("GroundTileMapLayer") as TileMapLayer
	var local_position := world.to_local(global_position)
	grid_position = world.local_to_map(local_position)

func handle_input() -> void:
	up = Input.get_action_strength("ui_up")
	down = Input.get_action_strength("ui_down")
	left = Input.get_action_strength("ui_left")
	right = Input.get_action_strength("ui_right")


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
