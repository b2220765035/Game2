class_name FierceTooth
extends CharacterBody2D

@export var speed: int = 100
@export var ray_cast: RayCast2D
@export var animator: AnimatedSprite2D

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var ft_wander_state = $FiniteStateMachine/FTWanderState as FTWanderState
@onready var ft_chase_state = $FiniteStateMachine/FTChaseState as FTChaseState
@onready var ft_attack_state = $FiniteStateMachine/FTAttackState as FTAttackState

@onready var health_bar = $health_bar


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null
var direction = -1

var maxHealth = 100
var health = maxHealth


func _ready():
	ft_wander_state.player_entered.connect(fsm.change_state.bind(ft_chase_state))
	
	ft_chase_state.player_exited.connect(fsm.change_state.bind(ft_wander_state))
	ft_chase_state.player_in_attack_range.connect(fsm.change_state.bind(ft_attack_state))
	
	ft_attack_state.player_exited_attack_range.connect(fsm.change_state.bind(ft_chase_state))


func _physics_process(delta):
	animator.flip_h = false if direction == -1 else true
	print(ray_cast.rotation_degrees)
	
	health_bar.value = health
	
	if not is_on_floor():
		velocity.y += gravity * delta

func change_direction():
	direction=-direction
	ray_cast.target_position.x = direction *30

func fierce_tooth():
	pass

