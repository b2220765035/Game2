class_name FTWanderState
extends State


signal player_entered


@export var fierce_tooth: FierceTooth
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	animator.play("run")
	if fierce_tooth.velocity == Vector2.ZERO:
		fierce_tooth.velocity.x = fierce_tooth.speed * fierce_tooth.direction


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	animator.flip_h = false if fierce_tooth.direction == -1 else true
	if ray_cast.is_colliding():
		fierce_tooth.change_direction()
		fierce_tooth.velocity.x = fierce_tooth.speed * fierce_tooth.direction
	fierce_tooth.move_and_slide()


func _on_eye_sight_body_entered(body):
	fierce_tooth.player = body
	player_entered.emit()
