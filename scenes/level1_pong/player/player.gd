extends StaticBody2D

@export var player1 : bool
var player_velocity : int = 500
var cpu_velocity : int = 500

@onready var ball : Area2D = $"../Ball"

func _process(delta):
	move_player(delta)
	player_move_limit()
	
func move_player(delta : float) -> void:
	if player1:
		if Input.is_action_pressed("mv-up-p1"):
			position.y -= player_velocity * delta
		elif Input.is_action_pressed("mv-down-p1"):
			position.y += player_velocity * delta
	else:
		if ball.position.y < position.y:
			position.y -= cpu_velocity * delta
		elif ball.position.y > position.y:
			position.y += cpu_velocity * delta
			
			
func player_move_limit() -> void:
	position.y = clamp(position.y, 64, 654)
