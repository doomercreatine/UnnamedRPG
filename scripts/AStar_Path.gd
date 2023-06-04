extends TileMap
class_name AStar_Path

# Retrieve all the tiles placed in the third layer
# These tiles are the 'solid' or non-moveable tiles
@onready var used_cells = get_used_cells(2) 
@onready var astargrid = AStarGrid2D.new()
const GRID_SIZE: Vector2i = Vector2i(40, 40)
const CELL_SIZE: Vector2i = Vector2i(16, 16)

var path

func _ready() -> void:
	# Populate the AStarGrid2D
	astargrid.size = GRID_SIZE
	astargrid.cell_size = CELL_SIZE
	astargrid.default_compute_heuristic = 3
	astargrid.diagonal_mode = 2
	
	# Adds all tiles to the grid
	astargrid.update()
	
	# Loop through the non-moveable tiles and set them to solid
	for cell in used_cells:
		astargrid.set_point_solid(cell)
	
	

func _get_path(start, end) -> void:
	path = astargrid.get_id_path(start, end)
	path.remove_at(0)
	
func _get_hover_path(start, end):
	var hpath = astargrid.get_id_path(start, end)
	hpath.remove_at(0)
	return hpath
