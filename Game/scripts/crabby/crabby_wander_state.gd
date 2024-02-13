class_name CrabbyWanderState
extends State


signal player_entered


@export var crabby: Crabby
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D
@export var eye_sight: Area2D


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
	if ray_cast.is_colliding():
		crabby.direction = -crabby.direction
		crabby.velocity.x = crabby.speed * crabby.direction
	
	var bodies = eye_sight.get_overlapping_bodies()
	if !bodies.is_empty():
		crabby.player = bodies[0]
		player_entered.emit()
	
	crabby.move_and_slide()
