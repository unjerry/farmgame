extends Node
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_N:
			DayManager.next_day()
		elif event.keycode == KEY_B:
			ShopManager.buy_seed()
		elif event.keycode == KEY_S:
			ShopManager.sell_crop()
