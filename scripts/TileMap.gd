extends AStar_Path

@onready var player := $"../Player"
@onready var cursor := $Cursor
@onready var target_tile := $TargetTile
@onready var world := $".."


var hover_mouse_position: Vector2
var path_tiles: Array[Node]

func _physics_process(delta):
	if world.visible:
		hover_mouse_position = local_to_map(get_global_mouse_position())
		cursor.position = map_to_local(hover_mouse_position)
		
