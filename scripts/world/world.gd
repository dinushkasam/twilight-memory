extends Node2D

@export var world_input_component: WorldInputComponent
@export var world_generator_component: WorldGeneratorCOmponent
@export var world_context: WorldContext
@export var config_provider: ConfigProvider
@export var game_obj_manager: GameObjectManager

@export var ground: TileMapLayer
@export var highlight: TileMapLayer

func _ready() -> void:
	# Initialize Game object manager
	game_obj_manager.init($GameObjects)
	
	# Initialize world context
	world_context.init(
		%GroundTileMapLayer,
		$GameObjectManager,
		%GroundHighlightTileMapLayer,
		$InteractionManager
	)
	
	# Initialize components with world context
	world_input_component.init(world_context)
	$Ysort/Player.init(world_context, config_provider)
	world_generator_component.init(world_context)
	
	# Generate the world with a given seed
	world_generator_component.generate_world_map(0)

func _process(_delta: float) -> void:
	world_input_component.process_updates()

func _input(event: InputEvent) -> void:
	world_input_component.process_input(event)
