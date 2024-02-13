class_name CrabbyDeathState
extends State


@export var crabby: Crabby
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	animator.play("dead_ground")


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	if animator.frame == 3:
		animator.stop()
