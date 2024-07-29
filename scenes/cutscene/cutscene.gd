extends Control

func _ready():
	$VideoStreamPlayer.play()

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func _on_button_pressed():
	_on_video_stream_player_finished()
