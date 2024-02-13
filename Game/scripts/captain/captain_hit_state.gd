class_name CaptainHitState
extends State


signal fall
signal idle
signal run


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	#captain.velocity.x += 20 * captain.direction
	if captain.has_sword:
		animator.play("hit sword")
	else:
		animator.play("hit")


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	#captain.velocity.x += 5 * (-captain.direction)

	if animator.frame == 3:
		if abs(captain.velocity.y) > 0:
			fall.emit()
		elif abs(captain.velocity.x) > 0:
			run.emit()
		elif captain.velocity == Vector2.ZERO:
			idle.emit()
	captain.move_and_slide()


func _get_state_name():
	return "captain hit state"
