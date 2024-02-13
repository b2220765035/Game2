class_name CaptainIdleState
extends State


signal movement_begin
signal jump
signal attack
signal throw_sword


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	if captain.has_sword:
		animator.play("idle sword")
	else:
		animator.play("idle")
	captain.velocity.x = 0


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	if Input.is_action_pressed("jump") and captain.can_jump:
		jump.emit()
	if Input.is_action_just_pressed("attack1") and captain.has_sword:
		attack.emit()
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		movement_begin.emit()
	if Input.is_action_just_pressed("attack2") and captain.has_sword:
		throw_sword.emit()
	captain.move_and_slide()


func _get_state_name():
	return "captain idle state"
