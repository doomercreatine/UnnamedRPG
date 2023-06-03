extends MarginContainer

var world = preload("res://scenes/world.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quitgame_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	var instance = world.instantiate()
	get_parent().add_child(instance)
	self.queue_free()

	
