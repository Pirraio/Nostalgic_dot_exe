extends Control

func _on_play_button_pressed():
	#get_tree().change_scene_to_file("res://")
	pass

func _on_about_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/about_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
