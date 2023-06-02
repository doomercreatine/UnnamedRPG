extends TileMap
class_name AStar_Path


@onready var used_cells = get_used_cells(2)
@onready var astargrid = AStarGrid2D.new()

var path

func _ready() -> void:
	astargrid.size = Vector2i(40, 22)
	astargrid.cell_size = Vector2i(16, 16)
	astargrid.default_compute_heuristic = 4
	astargrid.diagonal_mode = 2
	astargrid.update()
	
	for cell in used_cells:
		astargrid.set_point_solid(cell)
	
	

func _get_path(start, end) -> void:
	path = astargrid.get_id_path(start, end)
	path.remove_at(0)
	
func _get_hover_path(start, end):
	var hpath = astargrid.get_id_path(start, end)
	hpath.remove_at(0)
	return hpath
