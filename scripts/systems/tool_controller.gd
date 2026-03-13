extends Node
class_name ToolController


@export var tools: Array[ItemData]
var max_tools: int = 10

# Active variables
var active_index = 0
var active_tool: Item

# Signals
signal tool_changed(tool: ItemData, index: int)
signal tool_added(tool: ItemData, index: int)
signal tool_removed(tool: ItemData, index: int)
signal tool_cleared()


func init():
	max_tools = ConfigProvider.player_config.hotbar_max_tools
	tools.resize(max_tools)

func _ready() -> void:
	equip_tool(active_index)


func equip_tool(index: int):
	if active_tool:
		active_tool.queue_free()
	
	var new_tool_data = tools[index]
	
	if new_tool_data:
		active_tool = new_tool_data.item_scene.instantiate()
		active_tool.data = new_tool_data
		
		add_child(active_tool)
	
		print("Equipped slot [", index, "] tool: ", new_tool_data.item_name)
		tool_changed.emit(new_tool_data, index)
	else:
		print("Equipped slot [", index, "] tool: none")
		tool_cleared.emit()

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

func add_tool_to_slot(tool: ItemData, index: int):
	if index < max_tools:
		tools[index] = tool
		tool_added.emit(tool, index)

func remove_tool_from_slot(tool: ItemData, index: int):
	if index < max_tools:
		tools[index] = null
		tool_removed.emit(tool, index)
