extends Node2D
@onready var transition = $Transition

var cutscene = preload("res://scenes/cutscene/cutscene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_packed(cutscene)
