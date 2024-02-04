class_name CaptainJumpState
extends State


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	animator.play("jump sword")
	finished = false


func _exit_state() -> void:
	set_physics_process(false)


var finished = false
func _physics_process(delta):
	
	if Input.is_action_pressed("move_left"):
		captain.direction = -1
		captain.velocity.x = captain.direction * captain.speed
	elif Input.is_action_pressed("move_right"):
		captain.direction = 1
		captain.velocity.x = captain.direction * captain.speed
	else:
		captain.velocity.x = 0
	if captain.is_on_floor():
		if finished:
			state_finished.emit()
		else:
			finished = true
			captain.velocity.y = -350
	captain.move_and_slide()


func _get_state_name():
	return "captain jump state"
