extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var captain = $"../Captain"

const SPEED = 150
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	 #Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	var x_distance: int = captain.position.x - position.x

	if abs(x_distance) < 150:
		var abs_x_distance = max(1, abs(x_distance))
		velocity.x = x_distance / abs_x_distance * SPEED
	else:
		velocity.x = 0
	
	move_and_slide()

func _process(delta):
	if velocity.x == 0:
		_animated_sprite.play("idle")
	elif velocity.x > 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("run")
	elif velocity.x < 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("run")
