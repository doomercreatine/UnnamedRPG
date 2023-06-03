extends Node2D

@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	player.find_child("VisionLight").visible = false
	player.find_child("Torch").visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
