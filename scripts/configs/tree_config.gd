extends Resource
class_name TreeConfig

@export var animation_name: String
@export var max_health: int
@export var best_tool: Array[String]
@export var inefficient_tool: Array[String]

@export var best_tool_multiplier := 2.0
@export var inefficient_tool_multiplier := 0.5
@export var bare_hands_multiplier := 0.0
