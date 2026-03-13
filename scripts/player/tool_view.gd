extends AnimatedSprite2D
class_name ToolView


@export var animation_player: AnimationPlayer


func _ready() -> void:
	animation_player.play("tool_idle")



func _on_tool_controller_tool_changed(tool: ItemData, _index: int) -> void:
	self.scale = Vector2(1,1)
	self.play(tool.animation)


func _on_tool_controller_tool_cleared() -> void:
	self.scale = Vector2(0,0)
