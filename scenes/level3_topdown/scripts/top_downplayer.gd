extends CharacterBody2D

@export var speed = 250
var last_direction = Vector2.ZERO

var final = preload("res://scenes/cutscene_final.tscn")

@onready var transition = $"../Transition"
@onready var camera_2d = $Camera2D
@onready var sprite = $AnimatedSprite2D
@onready var player = $"."
@onready var color_rect = $"../ColorRect"

func _ready():
	color_rect.show()
	transition.play("RESET")
	color_rect.hide()
	transition.play("fade_in")
	$TextureRect.hide()
	
func _process(delta):
	var color_rect = transition.get_node("ColorRect")
	color_rect.scale.x = 3
	color_rect.scale.y = 3
	color_rect.position.x = player.position.x - 1024
	color_rect.position.y = player.position.y - 768

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	if direction != Vector2.ZERO:
		last_direction = direction
	if direction.x != 0:
			sprite.play("walk_side")
	elif direction.y < 0:
		sprite.play("walk_up")
	elif direction.y > 0:
		sprite.play("walk_down")
	if direction == Vector2.ZERO:
		sprite.play("idle")
	sprite.flip_h = last_direction.x > 0


func _on_area_2d_body_entered(_body):
	call_deferred("change_level")
	
func change_level():
	transition.play("fade_out")

		
func _on_timer_timeout():
	$TextureRect.show()
	await get_tree().create_timer(3).timeout
	$TextureRect.hide()


func _on_transition_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		get_tree().change_scene_to_packed(final)
