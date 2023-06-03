extends BaseUnit
# ===== Scene Imports =====
@onready var torch = $HeldItem/Torch
@onready var thought_timer = $ThoughtTimer
@onready var scroll_log = $"../LogCanvas/ScrollLog"
@onready var log_canvas = $"../LogCanvas"
@onready var vision_light = $VisionLight
# =========================

# ===== Player Variables ==
var has_torch: bool = false
const THOUGHT_COLOR: String = "red"
var light_default: int = 1
var is_moving: bool = false
# =========================


func _process(_delta) -> void:
	# Each frame check if the torch is equipped and change visibility radius
	if has_torch:
		vision_light.texture_scale = 10
		torch.show()
	else:
		torch.hide()
		vision_light.texture_scale = 2
		
func _physics_process(_delta) -> void:
	# Handle user input each physics frame
	get_input()
	

func get_input() -> void:
	# Toggle the torch on or off
	if Input.is_action_just_pressed("test"):
		# Torch only needed on specific maps which will be set in the map's script
		if vision_light.visible:
			has_torch = !has_torch
			if has_torch:
				scroll_log.append_text("\nYou equipped the torch.")
				scroll_log.append_text("\n[color=%s]I can see now![/color]" % THOUGHT_COLOR)
			else:
				scroll_log.append_text("\nYou unequipped the torch.")
				
	# Handles user movement on the grid			
	if Input.is_action_just_pressed("left_click"):
		# Only calculate movement if player not currently moving 
		if not is_moving:
			_calculate_movement_path(tile_map.local_to_map(get_global_mouse_position()))
		
# Takes in the clicked tile position and calculates the optimal path using the tile_map's AStarGrid2D
func _calculate_movement_path(target_pos: Vector2) -> void:
	var player_pos = tile_map.local_to_map(position)
	# Calculate the optimal path
	tile_map._get_path(player_pos, target_pos)
	if tile_map.path:
		scroll_log.append_text("\nMoved from %s to %s" % [player_pos, tile_map.path[-1]])
	# Loop through each tile in the optimal path and draw a white box over it
	for p in tile_map.path:
		var new_tile = tile_map.target_tile.duplicate()
		new_tile.position = tile_map.map_to_local(p)
		new_tile.position.x -= 8
		new_tile.position.y -= 8
		new_tile.show()			
		tile_map.path_tiles.append(new_tile)
		
	# Handle actual movement in its own function
	move()

# Flavor function to have the player think that it's dark
func _on_timer_timeout():
	if not has_torch and vision_light.visible:
		scroll_log.append_text("\n[color=%s]It's so dark...[/color]" % THOUGHT_COLOR)
				
func move():
	# Flag that the player is moving
	# Prevents the player from trying to move while already in motion
	is_moving = true
	
	# Add the overlay nodes to show the path
	for node in tile_map.path_tiles:
		tile_map.add_child(node)
		
	# Actually moves the player and removes the overlay tile as they move
	for p in tile_map.path:
		tile_map.path_tiles[0].queue_free()
		tile_map.path_tiles.remove_at(0)
		position = tile_map.map_to_local(p)
		await get_tree().create_timer(0.1).timeout
	
	# Reset movement flag so player can move again
	is_moving = false
