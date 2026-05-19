extends Node
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_N:
			DayManager.next_day()
		elif event.keycode == KEY_B:
			ShopManager.buy_seed()
		elif event.keycode == KEY_S:
			ShopManager.sell_crop()
		elif event.keycode == KEY_1:
			ToolManager.select_hotbar_slot(0)
		elif event.keycode == KEY_2:
			ToolManager.select_hotbar_slot(1)
		elif event.keycode == KEY_3:
			ToolManager.select_hotbar_slot(2)
		elif event.keycode == KEY_4:
			ToolManager.select_hotbar_slot(3)
