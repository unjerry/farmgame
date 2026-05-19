extends CanvasLayer
@onready var info_label: Label = $InfoLabel
func _ready() -> void:
	ToolManager.tool_changed.connect(update_info)
	InventoryManager.inventory_changed.connect(update_info)
	DayManager.day_changed.connect(update_info)
	update_info()
func update_info() -> void:
	info_label.text = "Day: %s\nTool: %s\nMoney: %s\nSeeds: %s\nCrops: %s" % [
		DayManager.current_day,
		ToolManager.current_tool,
		InventoryManager.money,
		InventoryManager.seed_count,
		InventoryManager.crop_count
	]
