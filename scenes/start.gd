extends Control

	
func _unhandled_input(event) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		swap_fullscreen_mode()
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func swap_fullscreen_mode() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
