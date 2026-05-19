extends CanvasLayer
@onready var info_label: Label = $InfoLabel
@onready var hotbar_label: Label = $HotbarLabel
@onready var inventory_label: Label = $InventoryLabel
var is_inventory_open := false
func _ready() -> void:
	ToolManager.tool_changed.connect(update_info)
	InventoryManager.inventory_changed.connect(update_info)
	DayManager.day_changed.connect(update_info)
	inventory_label.visible = is_inventory_open
	update_info()
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_I:
			toggle_inventory()
func toggle_inventory() -> void:
	is_inventory_open = not is_inventory_open
	inventory_label.visible = is_inventory_open
	update_inventory_text()
func update_info() -> void:
	update_status_text()
	update_hotbar_text()
	update_inventory_text()
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
func update_inventory_text() -> void:
	var all_items := InventoryManager.get_all_items()
	var lines := []
	lines.append("Inventory:")
	for item_id in all_items.keys():
		var count := int(all_items[item_id])
		if count <= 0:
			continue
		var item_data: Dictionary = ConfigManager.get_item_data(item_id)
		var display_name: String = item_data.get("display_name", item_id)
		lines.append("%s x%s" % [display_name, count])
	if lines.size() == 1:
		lines.append("(empty)")
	inventory_label.text = "\n".join(lines)
