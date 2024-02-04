class_name CaptainAttackState
extends State


@export var captain: Captain
@export var animator: AnimatedSprite2D
@export var attack_range: Area2D


var is_attacked: bool


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	is_attacked = false
	animator.play("attack 1")
	captain.velocity.x = 0


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	var enemies = attack_range.get_overlapping_bodies()
	for enemy in enemies:
		print(enemy.has_method("crabby"))
		print(animator.frame)
		print(is_attacked)
		if enemy.has_method("crabby") and animator.frame == 2 and !is_attacked:
			print("düşman hasar yedi")
			enemy.health -= 20
			is_attacked = true
		elif animator.frame == 0:
			is_attacked = false
	if animator.frame == 2:
		state_finished.emit()
	

func _get_state_name():
	return "captain attack state"
