extends Node
class_name ToolController

# Tool display
@export var animation_player: AnimationPlayer
@export var tool_sprite: AnimatedSprite2D

# Configs
var configs: ConfigProvider

@export var tools: Array[Item]
var max_tools: int = 10

# Active variables
var active_index = 0
var active_tool: Tool

# Signals
signal tool_changed(tool: Item, index: int)
signal tool_added(tool: Item, index: int)
signal tool_removed(tool: Item, index: int)


func init():
	max_tools = ConfigProvider.player_config.hotbar_max_tools
	tools.resize(max_tools)

func _ready() -> void:
	equip_tool(active_index)
	animation_player.play("tool_idle")


func equip_tool(index: int):
	if active_tool:
		active_tool.queue_free()
	
	var new_tool_data = tools[index]
	
	if new_tool_data:
		active_tool = new_tool_data.item_scene.instantiate()
		active_tool.data = new_tool_data
		
		# Tool sprite
		tool_sprite.scale = Vector2(1,1)
		tool_sprite.play(active_tool.data.animation)
		
		add_child(active_tool)
	
		print("Equipped slot [", index, "] tool: ", new_tool_data.item_name)
	else:
		print("Equipped slot [", index, "] tool: none")
		tool_sprite.scale = Vector2(0,0)
	tool_changed.emit(new_tool_data, index)

func cycle_next():
	active_index = (active_index + 1) % max_tools
	equip_tool(active_index)

func cycle_prev():
	active_index = (active_index - 1 + max_tools) % max_tools
	equip_tool(active_index)

func is_tool_equipped() -> bool:
	return true if active_tool else false

func use_tool(actor: Player, target_tile: Vector2i):
	active_tool.use(actor, target_tile)

func add_tool(tool: ToolData, index: int):
	if index < max_tools:
		tools[index] = tool
		tool_added.emit(tool, index)

func remove_tool(tool: ToolData, index: int):
	if index < max_tools:
		tools[index] = null
		tool_removed.emit(tool, index)
