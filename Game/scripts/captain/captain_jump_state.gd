class_name CaptainJumpState
extends State


signal fall
signal air_attack


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	captain.velocity.y = -350
	captain.can_jump = false
	if captain.has_sword:
		animator.play("jump sword")
	else:
		animator.play("jump")


func _exit_state() -> void:
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
	
	if captain.velocity.y >= 0:
		fall.emit()
	
	if Input.is_action_just_pressed("attack1") and captain.has_sword:
		air_attack.emit()

	captain.move_and_slide()


func _get_state_name():
	return "captain jump state"
