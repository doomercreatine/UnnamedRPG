extends Node2D

# ===== Scene Imports =====
@onready var player = $Player
# =========================

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set player visibility for the map.
	# This map will be in sunlight therefore no light needed
	player.find_child("VisionLight").visible = false
	player.find_child("Torch").visible = false

