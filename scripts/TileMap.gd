extends AStar_Path

@onready var player = $"../player"
@onready var cursor = $"../Cursor"
@onready var target_tile = $"../TargetTile"
@onready var world = $".."

var path_tiles: Array
var hover_mouse_position
var hover_tiles: Array
var is_moving: bool = false

func _input(event):
	if (world.visible and event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and not is_moving:
		var mouse_pos = local_to_map(get_global_mouse_position())
		var player_pos = local_to_map(player.position)
		target_tile.position = map_to_local(mouse_pos)
		target_tile.position.x -= 8
		target_tile.position.y -= 8
		target_tile.show()
		_get_path(player_pos, mouse_pos)
		for p in path:
			var new_tile = target_tile.duplicate()
			new_tile.position = map_to_local(p)
			new_tile.position.x -= 8
			new_tile.position.y -= 8
			new_tile.show()			
			path_tiles.append(new_tile)
		move()
			
func move():
	is_moving = true
	for node in path_tiles:
		self.add_child(node)
	for p in path:
		path_tiles[0].queue_free()
		path_tiles.remove_at(0)
		player.position = map_to_local(p)
		await get_tree().create_timer(0.1).timeout
	target_tile.hide()	
	is_moving = false

func _physics_process(delta):
	if world.visible:
		hover_mouse_position = local_to_map(get_global_mouse_position())
		cursor.position = map_to_local(hover_mouse_position)
		var player_pos = local_to_map(player.position)
		var hover_path = _get_hover_path(player_pos, hover_mouse_position)
		if !hover_tiles.is_empty():
			for ht in hover_tiles:
				hover_tiles[0].queue_free()
				hover_tiles.remove_at(0)
		for p in hover_path:
			var new_tile = target_tile.duplicate()
			new_tile.position = map_to_local(p)
			new_tile.position.x -= 8
			new_tile.position.y -= 8
			new_tile.color = Color(0, 255, 0, 0.05)
			new_tile.show()			
			hover_tiles.append(new_tile)
		if not is_moving:
			for ht in hover_tiles:
				self.add_child(ht)
