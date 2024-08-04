extends Node2D

signal cutscene_finished

var cutscene = preload("res://scenes/cutscene/cutscene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("change_scene")


func change_scene():
	get_tree().change_scene_to_packed(cutscene)
	
