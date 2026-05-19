extends Node
signal tool_changed
var current_tool := "hoe"
func set_tool(tool_name: String) -> void:
	current_tool = tool_name
	print("current tool: ", current_tool)
	tool_changed.emit()
