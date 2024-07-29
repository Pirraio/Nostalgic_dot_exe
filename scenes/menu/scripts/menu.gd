extends Control

func start():
	await get_tree().create_timer(1).timeout
	$"Play-Button/Play".play()

func _on_play_button_pressed():
	start()
	get_tree().change_scene_to_file("res://scenes/level1_pong/pong/pong.tscn")
	

	


func _on_about_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/about_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
