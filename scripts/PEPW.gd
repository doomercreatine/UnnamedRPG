extends Sprite2D

var has_played: bool = false
@onready var scroll_log = $"../LogCanvas/ScrollLog"



func _on_area_2d_area_entered(area):
	if not has_played:
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.queue_free()
		scroll_log.append_text("\n[color='green']PEPW: xQc beat this already.[/color]")
		has_played = true
	
