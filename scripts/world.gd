extends Node2D
@onready var player = $player
var battle = preload("res://scenes/battle_map.tscn")

func _ready() -> void:
	$TileMap/Cursor.show()
	player.find_child("VisionLight").visible = true
	
	
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




func _on_door_area_entered(area):
	var instance = battle.instantiate()
	get_parent().add_child(instance)
	self.queue_free()
