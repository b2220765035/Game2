extends RigidBody2D


@export var animator: AnimatedSprite2D
@export var wall_detector: RayCast2D
@export var area2d: Area2D


var direction: int
var is_embedded = false


func _ready():
	animator.play("spinning")


func _physics_process(delta):
	animator.flip_h = false if direction == 1 else true
	wall_detector.target_position.x = direction * 4
	if wall_detector.is_colliding() and !is_embedded:
		is_embedded = true
		linear_velocity = Vector2.ZERO
		global_position.x = wall_detector.get_collision_point().x - direction * 3
		animator.play("embedded")
	if is_embedded and animator.frame == 3:
		animator.pause()


func _process(delta):
	var bodies = area2d.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("captain"):
			body.has_sword = true
			queue_free()
