extends CharacterBody2D

@onready var tile_map = $"../TileMap"
@onready var torch = $Torch
@onready var thoughts = $Thoughts

const SPEED: float = 100.0
var target: Vector2 = position 
var has_torch: bool = false

@onready var point_light_2d = $PointLight2D
var light_default: int = 1
func _ready() -> void:
	var player_pos = tile_map.local_to_map(self.position)
	self.position = tile_map.map_to_local(player_pos)
	
	
func _physics_process(delta) -> void:
	get_input()
	if has_torch:
		point_light_2d.texture_scale = 10
		torch.show()
	else:
		torch.hide()
		point_light_2d.texture_scale = 2
		
	
	#if position.distance_to(target) > 5:
		#move_and_slide()
func get_input() -> void:
	if Input.is_action_just_pressed("test"):
		has_torch = !has_torch
		if has_torch:
			thoughts.text = "Much better."
			await get_tree().create_timer(1.5).timeout
			thoughts.text = ""
	



func _on_timer_timeout():
	if not has_torch:
		thoughts.text = "It's so dark..."
		await get_tree().create_timer(1.5).timeout
		thoughts.text = ""
