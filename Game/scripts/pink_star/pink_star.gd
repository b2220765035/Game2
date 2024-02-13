class_name PinkStar
extends CharacterBody2D


@export var wall_detector: RayCast2D
@export var gap_detector: RayCast2D
@export var eye_sight: RayCast2D


@onready var animator = $AnimatedSprite2D

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var pink_star_wander_state = $FiniteStateMachine/PinkStarWanderState as PinkStarWanderState
@onready var pink_star_attack_state = $FiniteStateMachine/PinkStarAttackState as PinkStarAttackState


const speed = 75


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1


func _ready():
	pink_star_wander_state.attack.connect(fsm.change_state.bind(pink_star_attack_state))
	
	pink_star_attack_state.wander.connect(fsm.change_state.bind(pink_star_wander_state))


func _physics_process(delta):
	animator.flip_h = false if direction == -1 else true
	
	if not is_on_floor():
		velocity.y += gravity * delta


func _change_direction():
	direction = -direction
	wall_detector.target_position.x = direction * 20
	gap_detector.position.x = direction * 8
	eye_sight.target_position.x = direction * 80
