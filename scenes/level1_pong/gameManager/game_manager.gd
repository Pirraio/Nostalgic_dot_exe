extends Node2D

enum Dialogue {
	INITIAL,
	ON_HIT,
	ON_POINT,
	SUFFERED_GOAL,
	RANDOM,
	ON_WIN
}

var player_points : int = 0
var cpu_points : int = 0
var player_win : bool = false 
var cpu_win : bool = false
var endgame : bool = false
var points_to_win : int = 3
var platform2D = preload("res://scenes/level2_2dplatform/plataforma_2d.tscn")

var rng = RandomNumberGenerator.new()

var player_dialogue_initial = ["Onde eu estou?", "Como eu vim parar aqui?", "Que lugar é esse?", "Ouch!"]
var player_dialogue_on_hit = ["Isso doeu!", "Ouch!"]
var player_dialogue_on_point = ["Estou entendendo como funciona...", "Acho que entendi o que preciso fazer...", "Parece que estou num jogo..."]
var player_dialogue_suffered_goal = ["Isso não foi legal!", "Assim não vale!", "A bola veio rápido demais!"]
var player_dialogue_random = ["Esse lugar... Parece familiar...", "Já estou ficando entendiado", "Parece que tudo ficou um pouco apertado... Apertado..."]
var player_dialogue_on_win = ["Entendi!", "Era só isso mesmo?"]

@onready var audioGoal : AudioStreamPlayer = $AudioGoal

@onready var ball : Area2D = $"../Ball"
@onready var playerPointsPanel : Label = $"../UI/PointsPanel/PlayerPoints"
@onready var CPUPointsPanel : Label = $"../UI/PointsPanel/CPUPoints"
@onready var transition = $"../Transition"

func _ready():
	print("comecou")
	transition.play("RESET")
	transition.play("fade_in")
	rng.randomize()
	show_player_say(Dialogue.INITIAL)
	var chance_of_random_dialogue = 1
	var random_number = rng.randi_range(0, 99)
	if random_number < chance_of_random_dialogue:
		show_player_say(Dialogue.RANDOM)
	$"Vitória".hide()
	$Derrota.hide()
	
func _process(delta):
	pass
	
func verify_end_game() -> void:
	if endgame:
		return
	if player_points == points_to_win:
		show_player_say(Dialogue.ON_WIN)
		player_win = true
		endgame = true
		$"../FieldMidLine".hide()
		$"Vitória".show()
		await get_tree().create_timer(3).timeout
		transition.play("fade_out")
		$"Vitória".hide()
		
		return
	if cpu_points == points_to_win:
		cpu_win = true
		endgame = true
		$"../FieldMidLine".hide()
		$Derrota.show()
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
		$Derrota.hide()
		return
		
func show_player_say(dialogue_type : Dialogue) -> void:
	$"../Player1/PlayerDialogue".visible = true
	match dialogue_type:
		Dialogue.INITIAL:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_initial.pick_random()
		Dialogue.RANDOM:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_random.pick_random()
		Dialogue.ON_HIT:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_on_hit.pick_random()
		Dialogue.ON_POINT:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_on_point.pick_random()
		Dialogue.SUFFERED_GOAL:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_suffered_goal.pick_random()
		Dialogue.ON_WIN:
			$"../Player1/PlayerDialogue/Message".text = player_dialogue_on_win.pick_random()
		_:
			print("Unknow")
	$"../Player1/PlayerDialogue/MessageTimeout".start()


func _on_goal_p_1_area_entered(area):
	cpu_points += 1
	CPUPointsPanel.text = str(cpu_points)
	show_player_say(Dialogue.SUFFERED_GOAL)
	audioGoal.play()
	verify_end_game()
	ball.reset_velocity()
	if !endgame:
		ball.run_timer()


func _on_goal_p_2_area_entered(area):
	player_points += 1
	playerPointsPanel.text = str(player_points)
	audioGoal.play()
	show_player_say(Dialogue.ON_POINT)
	verify_end_game()
	ball.reset_velocity()
	if !endgame:
		ball.run_timer()


func _on_message_timeout_timeout():
	$"../Player1/PlayerDialogue".hide()


func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(platform2D)
