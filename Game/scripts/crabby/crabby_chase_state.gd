class_name CrabbyChaseState
extends State


signal player_exited
signal player_in_attack_range


@export var crabby: Crabby
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D
@export var eye_sight: Area2D


func _ready():
	set_physics_process(false)
	
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("run")


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	var x_distance = crabby.player.position.x - crabby.position.x
	
	if x_distance == 0: x_distance = 1
	crabby.direction = x_distance / abs(x_distance)

	if abs(x_distance) > 30:
		crabby.velocity.x = crabby.direction * crabby.speed
	else:
		crabby.velocity.x = 0
		player_in_attack_range.emit()
		
	var bodies = eye_sight.get_overlapping_bodies()
	if bodies.is_empty():
		crabby.player = null
		player_exited.emit()
	
	crabby.move_and_slide()
