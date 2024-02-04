class_name CrabbyAttackState
extends State


signal player_exited_attack_range


@export var crabby: Crabby
@export var animator: AnimatedSprite2D
@export var eye_sight: Area2D
@export var attack_range: Area2D


var is_attacked: bool


func _ready():
	set_physics_process(false)
	

func _enter_state() -> void:
	set_physics_process(true)
	is_attacked = false
	animator.play("attack")


func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	var x_distance = crabby.player.position.x - crabby.position.x
	if x_distance >= 0:
		crabby.direction = 1
	elif x_distance < 0:
		crabby.direction = -1
	if abs(x_distance) > 30:
		player_exited_attack_range.emit()
		
	var captain = attack_range.get_overlapping_bodies()[0]
	if captain and animator.frame == 2 and !is_attacked:
		captain.health -= 20
		is_attacked = true
	elif animator.frame == 0:
		is_attacked = false
