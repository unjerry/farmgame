extends CanvasLayer
@onready var info_label: Label = $InfoLabel
@onready var hotbar_label: Label = $HotbarLabel
func _ready() -> void:
	ToolManager.tool_changed.connect(update_info)
	InventoryManager.inventory_changed.connect(update_info)
	DayManager.day_changed.connect(update_info)
	update_info()
func update_info() -> void:
	update_status_text()
	update_hotbar_text()
func update_status_text() -> void:
	var select_item_name: String = ToolManager.get_selected_item_name()
	info_label.text = "Day: %s\nTool: %s\nMoney: %s\nSeeds: %s\nCrops: %s" % [
		DayManager.current_day,
		select_item_name,
		InventoryManager.money,
		InventoryManager.get_item_count("turnip_seed"),
		InventoryManager.get_item_count("turnip")
	]
func update_hotbar_text() -> void:
	var parts := []
	for i in ToolManager.hotbar_items.size():
		var item_id: String = ToolManager.hotbar_items[i]
		var item_data: Dictionary = ConfigManager.get_item_data(item_id)
		var display_name: String = item_data.get("display_name", item_id)
		var item_type: String = item_data.get("type", "")
		var text := "%s %s" % [i + 1, display_name]
		if item_type == "seed" or item_type == "crop":
			var count := InventoryManager.get_item_count(item_id)
			text += " x%s"%count
		if item_id == ToolManager.selected_item_id:
			text = "[%s]"%text
		else:
			text = " %s "%text
		parts.append(text)
	hotbar_label.text = " ".join(parts)
