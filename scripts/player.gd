extends CharacterBody2D

@onready var tile_map = $"../TileMap"
@onready var torch = $Torch
@onready var thoughts = $Thoughts
@onready var rich_text_label = $"../CanvasLayer2/RichTextLabel"

const SPEED: float = 100.0
var target: Vector2 = position 
var has_torch: bool = false
const THOUGHT_COLOR: String = "red"


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
			rich_text_label.append_text("\nYou equipped the torch.")
			rich_text_label.append_text("\n[color=%s]I can see now![/color]" % THOUGHT_COLOR)
		else:
			rich_text_label.append_text("\nYou unequipped the torch.")
	



func _on_timer_timeout():
	if not has_torch:
		rich_text_label.append_text("\n[color=%s]It's so dark...[/color]" % THOUGHT_COLOR)
		


func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("enemies"):
		rich_text_label.append_text("\n[color=%s]What the[/color]" % THOUGHT_COLOR)


func _on_area_2d_area_entered(area):
	print(area)
