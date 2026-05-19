extends Node
var seed_item_id := "turnip_seed"
var crop_item_id := "turnip"
func buy_seed() -> void:
	var seed_data: Dictionary = ConfigManager.get_item_data(seed_item_id)
	var seed_price: int = seed_data.get("buy_price", 10)
	if not InventoryManager.spend_money(seed_price):
		return
	InventoryManager.add_item(seed_item_id, 1)
func sell_crop() -> void:
	var crop_data: Dictionary = ConfigManager.get_item_data(crop_item_id)
	var crop_price: int = crop_data.get("sell_price", 25)
	if not InventoryManager.remove_item(crop_item_id, 1):
		return
	InventoryManager.add_money(crop_price)
