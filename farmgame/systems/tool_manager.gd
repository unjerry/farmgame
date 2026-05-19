extends Node
signal tool_changed
var selected_item_id := "hoe"
var hotbar_items := [
	"hoe",
	"turnip_seed",
	"watering_can",
	"hand"
]
func select_hotbar_slot(slot_index: int) -> void:
	if slot_index < 0:
		return
	if slot_index >= hotbar_items.size():
		return
	selected_item_id = hotbar_items[slot_index]
	print("selected item: ", selected_item_id)
	tool_changed.emit()
func get_selected_item_data() -> Dictionary:
	return ConfigManager.get_item_data(selected_item_id)
func get_selected_item_name() -> String:
	var item_data: Dictionary = get_selected_item_data()
	return item_data.get("display_name", selected_item_id)
