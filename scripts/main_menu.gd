extends MarginContainer

@onready var world = $"../world"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quitgame_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	self.hide()
	world.show()
	self.queue_free()

	
