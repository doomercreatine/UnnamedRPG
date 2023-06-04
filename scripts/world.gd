extends Node2D
@onready var player = $player
var battle = preload("res://scenes/battle_map.tscn")

func _ready() -> void:
	$TileMap/Cursor.show()
	player.find_child("VisionLight").visible = true
	




func _on_door_area_entered(area):
	var instance = battle.instantiate()
	get_parent().add_child(instance)
	self.queue_free()
