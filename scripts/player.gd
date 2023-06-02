extends CharacterBody2D

@onready var tile_map = $"../TileMap"

const SPEED: float = 100.0
var target: Vector2 = position 

func _ready() -> void:
	var player_pos = tile_map.local_to_map(self.position)
	self.position = tile_map.map_to_local(player_pos)

func _physics_process(delta) -> void:
	velocity = position.direction_to(target) * SPEED
	
	#if position.distance_to(target) > 5:
		#move_and_slide()
func get_input() -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	

