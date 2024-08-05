extends Control

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu2.tscn")



func _on_exit_button_pressed():
	get_tree().quit()
