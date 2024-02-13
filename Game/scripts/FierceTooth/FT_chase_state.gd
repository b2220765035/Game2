class_name FTChaseState
extends State


signal player_exited
signal player_in_attack_range

@export var fierce_tooth: FierceTooth
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D


func _ready():
	set_physics_process(false)
	
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("run")


func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	var x_distance = fierce_tooth.player.position.x - fierce_tooth.position.x
	if x_distance == 0: x_distance = 1
	if fierce_tooth.direction != x_distance / abs(x_distance):fierce_tooth.change_direction()
	animator.flip_h = false if fierce_tooth.direction == -1 else true
	print(abs(x_distance))
	if abs(x_distance) > 21:
		fierce_tooth.velocity.x = fierce_tooth.direction * fierce_tooth.speed*1.3
	else:
		fierce_tooth.velocity.x = 0
		player_in_attack_range.emit()
	fierce_tooth.move_and_slide()


func _on_eye_sight_body_exited(body):
	fierce_tooth.player = null
	player_exited.emit()
