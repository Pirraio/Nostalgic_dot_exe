extends Control

@onready var transition = $Transition

var pong_level = preload("res://scenes/level1_pong/pong/pong.tscn")
var about_menu = preload("res://scenes/menu/about_menu.tscn")


func _ready():
	transition.play("RESET")
	transition.play("fade_in")

func start():
	$"Play-Button/Play".play()

func _on_play_button_pressed():
	start()
	await get_tree().create_timer(1).timeout
	transition.play("fade_out")
	

func _on_about_button_pressed():
	get_tree().change_scene_to_packed(about_menu)


func _on_exit_button_pressed():
	get_tree().quit()

func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(pong_level)


