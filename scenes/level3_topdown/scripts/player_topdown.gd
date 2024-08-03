#extends CharacterBody2D
#
#@export var speed = 250
#var last_direction = Vector2.ZERO
#
#var final = preload("res://scenes/cena_final.tscn")
#
#
#@onready var transition = $"../Transition"
#
#@onready var sprite = $AnimatedSprite2D
#
#func _ready():
	#transition.get_node("ColorRect").visible = false
	#$TextureRect.hide()
	#
#
#func _physics_process(_delta):
	#var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#velocity = direction * speed
	#move_and_slide()
	#if direction != Vector2.ZERO:
		#last_direction = direction
	#if direction.x != 0:
			#sprite.play("walk_side")
	#elif direction.y < 0:
		#sprite.play("walk_up")
	#elif direction.y > 0:
		#sprite.play("walk_down")
	#if direction == Vector2.ZERO:
		#sprite.play("idle")
	#sprite.flip_h = last_direction.x > 0
#
#
#func _on_area_2d_body_entered(_body):
	#call_deferred("change_level")
	#
#func change_level():
	#get_tree().change_scene_to_packed(final)
	##transition.play("fade_out")
#
		#
#func _on_timer_timeout():
	#$TextureRect.show()
	#await get_tree().create_timer(3).timeout
	#$TextureRect.hide()
#
#
#func _on_transition_animation_finished(anim_name):
	#pass
