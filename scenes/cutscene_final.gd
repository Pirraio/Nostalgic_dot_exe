extends Control

@onready var color_rect = $ColorRect
@onready var transition = $Transition
var menu = preload("res://scenes/menu/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.visible = true
	await get_tree().create_timer(3).timeout
	color_rect.visible = false
	transition.play("fade_in")
	await get_tree().create_timer(10).timeout
	transition.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(menu)

