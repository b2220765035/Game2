class_name CrabbyWanderState
extends State


signal player_entered


@export var crabby: Crabby
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	animator.play("run")
	if crabby.velocity == Vector2.ZERO:
		crabby.velocity.x = crabby.speed * crabby.direction


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	animator.flip_h = false if crabby.direction == -1 else true
	if ray_cast.is_colliding():
		crabby.direction = -crabby.direction
		crabby.velocity.x = crabby.speed * crabby.direction
	crabby.move_and_slide()


func _on_eye_sight_body_entered(body):
	crabby.player = body
	player_entered.emit()
