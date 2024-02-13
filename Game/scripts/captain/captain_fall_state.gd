class_name CaptainFallState
extends State


signal run
signal idle
signal air_attack


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	if captain.has_sword:
		animator.play("fall sword")
	else:
		animator.play("fall")


func _exit_state() -> void:
	captain.can_jump = true
	set_physics_process(false)


func _physics_process(delta):
	
	if Input.is_action_pressed("move_left"):
		captain.direction = -1
		captain.velocity.x = captain.direction * captain.speed
	elif Input.is_action_pressed("move_right"):
		captain.direction = 1
		captain.velocity.x = captain.direction * captain.speed
	else:
		captain.velocity.x = 0
	
	if Input.is_action_just_pressed("attack1") and captain.has_sword:
		air_attack.emit()
	
	if captain.is_on_floor():
		if abs(captain.velocity.x) > 0:
			run.emit()
		else:
			idle.emit()
	
	captain.move_and_slide()


func _get_state_name():
	return "captain fall state"
