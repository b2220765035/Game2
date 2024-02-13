class_name CaptainAirAttackState
extends State


signal run
signal idle


@export var captain: Captain
@export var animator: AnimatedSprite2D
@export var air_attack_range: Area2D


var is_attacked: bool


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	is_attacked = false
	captain.is_falling = false
	captain.velocity = Vector2.ZERO
	animator.play("air attack 2")


func _exit_state() -> void:
	captain.is_falling = true
	set_physics_process(false)


func _physics_process(delta):
	var enemies = air_attack_range.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.has_method("crabby") and animator.frame == 2 and !is_attacked:
			enemy.take_damage(50)
			is_attacked = true
	
	if animator.frame == 2:
		state_finished.emit()
	if captain.is_on_floor():
		if abs(captain.velocity.x) > 0:
			run.emit()
		else:
			idle.emit()
	
	captain.move_and_slide()


func _get_state_name():
	return "captain air attack state"
