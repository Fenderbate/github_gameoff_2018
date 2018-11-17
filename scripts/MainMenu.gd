extends Control

export(String) var game_path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_button_down():
	if get_tree().change_scene(game_path) == 0:
		return
	else:
		print("NOPE")
		
