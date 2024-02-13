class_name PinkStarWanderState
extends State


signal attack


@export var pink_star: PinkStar
@export var animator: AnimatedSprite2D
@export var wall_detector: RayCast2D
@export var gap_detector: RayCast2D
@export var eye_sight: RayCast2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	pink_star.velocity.x = pink_star.direction * pink_star.speed
	animator.play("run")
	set_physics_process(true)


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	if eye_sight.is_colliding():
		attack.emit()
	
	if wall_detector.is_colliding() or not gap_detector.is_colliding():
		pink_star._change_direction()
		pink_star.velocity.x = pink_star.direction * pink_star.speed
	pink_star.move_and_slide()
