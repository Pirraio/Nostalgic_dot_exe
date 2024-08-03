extends ColorRect

@onready var transition = $Transition
var menu = preload("res://scenes/menu/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fade_in")
	await get_tree().create_timer(3).timeout
	transition.play("fade_out")

func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(menu)
