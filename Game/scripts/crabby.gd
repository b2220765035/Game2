extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _captain = $Captain

const SPEED = 100
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_chase = false
var player = null
var is_alive = true


func crabby():
	pass

func _physics_process(delta):
	if is_alive:
		if not is_on_floor():
			velocity.y += gravity * delta
			
		if player_chase:
			var x_distance = player.position.x - position.x
			var x_direction: int
			if x_distance == 0:
				x_direction = 0
			else:
				x_direction = x_distance / abs(x_distance)
			velocity.x = x_direction * SPEED
		else:
			velocity.x = 0
	
	move_and_slide()

var animation_finished = false
func _process(delta):
	if !is_alive:
		if !animation_finished:
			_animated_sprite.play("dead_hit")
		if _animated_sprite.frame == 3:
			animation_finished = true
		if animation_finished:
			_animated_sprite.play("dead_ground")

	elif velocity.x == 0:
		_animated_sprite.play("idle")
	elif velocity.x > 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("run")
	elif velocity.x < 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("run")


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
