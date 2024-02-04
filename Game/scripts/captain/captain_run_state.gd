class_name CaptainRunState
extends State


signal movement_stop
signal jump
signal attack


@export var captain: Captain
@export var animator: AnimatedSprite2D
@export var attack_range: Area2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	animator.play("run sword")


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):

	if Input.is_action_just_pressed("jump"):
		jump.emit()
	if Input.is_action_just_pressed("attack1"):
		attack.emit()
	if Input.is_action_pressed("move_left"):
		captain.direction = -1
		captain.velocity.x = captain.direction * captain.speed
	elif Input.is_action_pressed("move_right"):
		captain.direction = 1
		captain.velocity.x = captain.direction * captain.speed
	else:
		movement_stop.emit()
	captain.move_and_slide()
	

func _get_state_name():
	return "captain run state"
	
