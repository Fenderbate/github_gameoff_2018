extends Control

export(PackedScene) var target_scene

var pointer_pos = 0 setget pointer_pos_changed
var pointer_pivot = Vector2()

var are_options_on_screen = false

func _ready():
	pointer_pivot = Vector2($Main/Pointer.rect_size.x/2,$Main/Pointer.rect_size.y/2)
	$Main/Pointer.rect_global_position = $Main/PlayButton/PointerPos.global_position - pointer_pivot
	if OS.get_name() == "HTML":
		$Main/ExitButton.hide()

func _input(event):
	
	if Input.is_action_just_pressed("player_1_down"):
		self.pointer_pos+=1
	if Input.is_action_just_pressed("player_1_up"):
		self.pointer_pos-=1
	if Input.is_action_just_pressed("player_1_shoot"):
		enter_menu(pointer_pos)
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and !event.pressed:
			if $Options/Music.has_focus():
				print("asd")
				$Options/Music.release_focus()
				$Music.stream_paused = true
			if $Options/Sound.has_focus():
				$Options/Music.release_focus()
				$Sound.play()

func enter_menu(index):
	
	match index:
		0:
			_on_PlayButton_button_down()
		1:
			_on_OptionsButton_button_down()
		2:
			_on_ExitButton_button_down()
		_:
			print("Menu unindentified: ",index)
	


	

func pointer_pos_changed(value):
	
	if value > 2 or value < 0:
			return
	
	pointer_pos = value
	
	match value:
		0:
			$Main/Pointer.rect_global_position = $Main/PlayButton/PointerPos.global_position - pointer_pivot
		1:
			$Main/Pointer.rect_global_position = $Main/OptionsButton/PointerPos.global_position - pointer_pivot
		2:
			if OS.get_name() != "HTML":
				$Main/Pointer.rect_global_position = $Main/ExitButton/PointerPos.global_position - pointer_pivot
				return
			pointer_pos = 1
		_:
			print("something vent wrong...",value)
		


func _on_PlayButton_button_down():
	Global.change_scene(target_scene)


func _on_OptionsButton_button_down():
	
	if $AnimationPlayer.is_playing():
		return
	
	match are_options_on_screen:
		true:
			$AnimationPlayer.play("optionsOut")
			are_options_on_screen = false
			return
		false:
			$AnimationPlayer.play("optionsIn")
			are_options_on_screen = true
			return
		_:
			print("something went wrong with the options animation")
	


func _on_ExitButton_button_down():
	$ExitGamePopup.show()
	print("Don't show this option on web export (MainMenu.gd)")


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


func _on_Music_focus_entered():
	if $Music.stream_paused:
		$Music.stream_paused = false
		return
	$Music.play()


func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),value)


func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
