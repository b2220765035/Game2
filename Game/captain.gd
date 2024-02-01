extends CharacterBody2D


@onready var _animated_sprite = $AnimatedSprite2D
@export var gravity= 30
var is_sprinting=false
var sprint_value=1

func _physics_process(delta):

	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 400:
			velocity.y=450

	if Input.is_action_pressed("sprint") and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		is_sprinting=true
		sprint_value=1.8
		_animated_sprite.speed_scale = 1.5
	else:
		is_sprinting=false
		sprint_value=1
		_animated_sprite.speed_scale = 1


	if Input.is_action_just_pressed("jump") and is_on_floor():
		_animated_sprite.play("jump sword")
		velocity.y =-800


	var direction = Input.get_axis("move_left","move_right")

	velocity.x = 200 * direction * sprint_value
	move_and_slide()

func _process(delta):
	if velocity.y < 0:
		_animated_sprite.flip_h=Input.is_action_pressed("move_left")
		_animated_sprite.play("jump sword")
	elif velocity.y > 0:
		_animated_sprite.flip_h=Input.is_action_pressed("move_left")
		_animated_sprite.play("fall sword")
	elif Input.is_action_pressed("move_right"):
		_animated_sprite.flip_h=false
		_animated_sprite.play("run sword")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.flip_h=true
		_animated_sprite.play("run sword")
	else:
		_animated_sprite.play("idle")
