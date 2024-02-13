class_name PinkStarAttackState
extends State


signal wander


@export var pink_star: PinkStar
@export var animator: AnimatedSprite2D
@export var wall_detector: RayCast2D
@export var gap_detector: RayCast2D
@export var eye_sight: RayCast2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	pink_star.velocity.x = pink_star.velocity.x * 3
	animator.play("attack")
	set_physics_process(true)


func _exit_state() -> void:
	pink_star.velocity.x = 0
	set_physics_process(false)


func _physics_process(delta):
	
	if wall_detector.is_colliding() or not gap_detector.is_colliding():
		pink_star._change_direction()
		
		wander.emit()
	pink_star.move_and_slide()
