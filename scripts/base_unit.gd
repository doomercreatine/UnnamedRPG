extends CharacterBody2D
class_name BaseUnit

@export var unit_name: String
@export var health: int = 100
@export var attack: int = 0
@export var defense: int = 10
@export var strength: int = 5
@export var constitution: int = 5
@export var intelligence: int = 5
@export var charisma: int = 5
@onready var tile_map = $"../TileMap"

func _ready() -> void:
	# Center the unit on the closest tile
	var unit_pos = tile_map.local_to_map(self.position)
	self.position = tile_map.map_to_local(unit_pos)
