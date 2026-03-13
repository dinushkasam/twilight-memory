extends Node2D

@export var world_input_component: WorldInputComponent
@export var world_generator_component: WorldGeneratorComponent
@export var config_provider: ConfigProvider
@export var game_obj_manager: GameObjectManager

@export var ground: TileMapLayer
@export var highlight: TileMapLayer

@export var game_config: GameConfig
@export var player_config: PlayerConfig


func _ready() -> void:
	# Initialize world context and services
	WorldContext.init(
		$GroundTileMapLayer,
		$GroundHighlightTileMapLayer,
		$GameObjectRegistry,
		$CropRegistry
	)
	WorldServices.init(
		$GameObjectManager,
		$InteractionManager,
	)
	ConfigProvider.init(
		game_config,
		player_config
	)
	
	# Initialize player
	$Ysort/Player.init()
	
	# Generate the world with a given seed
	world_generator_component.generate_world_map(0)

func _process(_delta: float) -> void:
	world_input_component.process_updates()

func _input(event: InputEvent) -> void:
	world_input_component.process_input(event)
