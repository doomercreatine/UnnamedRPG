extends AStar_Path
# ===== Scene Imports =====
@onready var player := $"../Player"
@onready var cursor := $Cursor
@onready var target_tile := $TargetTile
@onready var world := $".."
# =========================

# ===== Local Variables ===
var hover_mouse_position: Vector2
var path_tiles: Array[Node] # Holds the AStarGrid2D path that was called from player
# =========================

func _process(_delta):
	# For each frame show the hovered tile
	if world.visible:
		hover_mouse_position = local_to_map(get_global_mouse_position())
		cursor.position = map_to_local(hover_mouse_position)
		if self.astargrid.is_point_solid(hover_mouse_position):
			cursor.modulate = Color(255, 255, 255, 0)
		else:
			cursor.modulate = Color(255, 255, 255, 1)
		
