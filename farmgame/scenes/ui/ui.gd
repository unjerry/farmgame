extends CanvasLayer
@onready var info_label: Label = $InfoLabel
func _ready() -> void:
	update_info()
func update_info() -> void:
	info_label.text = "
	Day: %s\n
	Tool: %s\n
	Seeds: %s\n
	Crops: %s
	" % [
		DayManager.current_day,
		ToolManager.current_tool,
		InventoryManager.seed_count,
		InventoryManager.crop_count
	]