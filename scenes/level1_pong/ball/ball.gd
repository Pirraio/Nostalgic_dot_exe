extends Area2D

var ball_initial_velocity : int = 350
var ball_velocity : int = 500
var initial_position : Vector2 = Vector2(512, 384)
var initial_direction : Vector2 = Vector2(0, 0)
var new_direction : Vector2 = Vector2(0, 0)



var y_min : float = 0
var y_max : float = 768

@onready var timer : Timer = $Timer

@onready var soundGoalImpact : AudioStreamPlayer = $SoundGoalImpact
@onready var soundPlayerImpact : AudioStreamPlayer = $SoundPlayerImpact

# Called when the node enters the scene tree for the first time.
func _ready():
	
	await get_tree().create_timer(3).timeout
	reset_ball_position()
	define_initial_direction()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_ball(delta)
	check_wall_colision()

func run_timer() -> void:
	timer.start()


func check_wall_colision() -> void:
	if position.y >= y_max or position.y <= y_min:
		new_direction.y *= -1
		if position.x >= 0 and position.x <= 1024:
			soundGoalImpact.play()
		

func define_initial_direction() -> void:
	var x_random = [-1, 1].pick_random()
	var y_random = [-1, 1].pick_random()
	
	initial_direction = Vector2(x_random, y_random)
	new_direction = initial_direction


func reset_ball_position() -> void:
	position = initial_position
	define_initial_direction()


func move_ball(delta) -> void:
	position += new_direction * ball_velocity * delta
	
func reset_velocity() -> void:
	ball_velocity = ball_initial_velocity
	
func _on_body_entered(body):
	if body.is_in_group("players"):
		ball_velocity += 75
		new_direction.x *= -1
		soundPlayerImpact.play()
		if position.x < 130: #gam
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var chance_of_hitting = 9
			var random_number = rng.randi_range(0, 99)
			if random_number < chance_of_hitting:
				if random_number % 2 == 0:
					$"../GameManager".show_player_say($"../GameManager".Dialogue.ON_HIT)
				else:
					$"../GameManager".show_player_say($"../GameManager".Dialogue.RANDOM)


func _on_timer_timeout():
	reset_ball_position()
