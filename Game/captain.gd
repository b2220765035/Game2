extends CharacterBody2D


@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","jump","crouch")
	velocity= direction*200
	move_and_slide()
	
func _process(delta):
	if Input.is_action_pressed("move_right"):
		_animated_sprite.flip_h=false
		_animated_sprite.play("run sword")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.flip_h=true
		_animated_sprite.play("run sword")
	else:
		_animated_sprite.stop()
	

