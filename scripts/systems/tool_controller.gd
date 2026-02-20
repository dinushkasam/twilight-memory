extends Node
class_name ToolController

# Configs
@export var tools: Array[ToolData]
var max_tools: int

# Active variables
var active_index = 0
var active_tool: Tool

# Signals
signal tool_changed(tool: ToolData, index: int)
signal tool_added(tool: ToolData, index: int)
signal tool_removed(tool: ToolData, index: int)


func init(hotbar_max_tools: int):
	max_tools = hotbar_max_tools
	tools.resize(max_tools)

func _ready() -> void:
	equip_tool(active_index)


func equip_tool(index: int):
	if active_tool:
		active_tool.queue_free()
	
	var new_tool_data = tools[index]
	active_tool = new_tool_data.tool_scene.instantiate()
	active_tool.data = new_tool_data
	
	add_child(active_tool)
	
	tool_changed.emit(new_tool_data, index)

func cycle_next():
	active_index = (active_index + 1) % max_tools
	equip_tool(active_index)

func cycle_prev():
	active_index = (active_index - 1 + max_tools) % max_tools
	equip_tool(active_index)

func use_tool(actor: Player, target_tile: Vector2i) -> bool:
	if active_tool:
		active_tool.use(actor, target_tile)
		return true
	else:
		return false

func add_tool(tool: ToolData, index: int):
	if index < max_tools:
		tools[index] = tool
		tool_added.emit(tool, index)

func remove_tool(tool: ToolData, index: int):
	if index < max_tools:
		tools[index] = null
		tool_removed.emit(tool, index)
