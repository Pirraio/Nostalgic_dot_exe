extends Control

@onready var color_rect = $ColorRect

var menu = preload("res://scenes/menu/menu.tscn")

func _ready():
	$VideoStreamPlayer.play()
	color_rect.visible = false

func _on_video_stream_player_finished():
	#transition.play("fade_in")
	color_rect.visible = true
	get_tree().change_scene_to_packed(menu)

func _on_button_pressed():
	_on_video_stream_player_finished()
