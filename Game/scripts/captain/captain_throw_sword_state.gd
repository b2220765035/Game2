class_name CaptainThrowSwordState
extends State


@export var captain: Captain
@export var animator: AnimatedSprite2D


func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	captain.has_sword = false
	animator.play("throw sword")


func _exit_state() -> void:
	captain.sword_instance = captain.sword_scene.instantiate()
	add_sibling(captain.sword_instance)
	captain.sword_instance.global_position.y = captain.global_position.y
	captain.sword_instance.global_position.x = captain.global_position.x + (captain.direction * 20)
	captain.sword_instance.linear_velocity.x = captain.direction * 200
	captain.sword_instance.direction = captain.direction
	set_physics_process(false)


func _physics_process(delta):
	if animator.frame == 2:
		state_finished.emit()
	captain.move_and_slide()
	

func _get_state_name():
	return "captain throw sword state"
	
