extends Node
var seed_price := 10
var crop_price := 25
func buy_seed() -> void:
	if not InventoryManager.spend_money(seed_price):
		return
	InventoryManager.add_seed()
func sell_crop() -> void:
	if not InventoryManager.remove_crop():
		return
	InventoryManager.add_money(crop_price)
