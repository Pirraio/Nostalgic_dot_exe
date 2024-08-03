extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300
@onready var transition = $"../Transition"

@onready var sprite = $AnimatedSprite2D
@onready var camera_player = $CameraPlayer
var topdown = preload("res://scenes/level3_topdown/topdown.tscn")



func _ready():
	#print(color_rect.position)
	#print(camera_player.limit_left)
	transition.play("fade_in")
	$Balao.hide()
	$Balao/Timer.start()

func _process(delta):
	var color_rect = transition.get_node("ColorRect")
	color_rect.scale.x = 5
	color_rect.scale.y = 5
	color_rect.position.x = camera_player.limit_left
	color_rect.position.y = camera_player.limit_top

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 100
	if Input.is_action_just_pressed("jump") && is_on_floor():
			velocity.y = -jump_force
	
	var h_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * h_direction
	
	move_and_slide()
	
	if h_direction != 0:
		sprite.flip_h = h_direction == -1
	
	update_animations(h_direction)
	
func update_animations(h_direction):
		if h_direction == 0:
			sprite.play("idle")
		else:
			sprite.play("walk")

func _on_area_2d_body_entered(body):
		call_deferred("change_level")

func change_level():
	transition.play("fade_out")


func _on_timer_timeout():
	$Balao.show()
	await await get_tree().create_timer(3).timeout
	$Balao.hide()


func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(topdown)
