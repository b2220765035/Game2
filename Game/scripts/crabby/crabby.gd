class_name Crabby
extends CharacterBody2D

@export var speed: int = 75
@export var ray_cast: RayCast2D
@export var animator: AnimatedSprite2D


@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var crabby_wander_state = $FiniteStateMachine/CrabbyWanderState as CrabbyWanderState
@onready var crabby_chase_state = $FiniteStateMachine/CrabbyChaseState as CrabbyChaseState
@onready var crabby_death_state = $FiniteStateMachine/CrabbyDeathState as CrabbyDeathState
@onready var crabby_attack_state = $FiniteStateMachine/CrabbyAttackState as CrabbyAttackState

@onready var health_bar = $health_bar


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null
var direction = -1

var maxHealth = 100
var health = maxHealth


func _ready():
	crabby_wander_state.player_entered.connect(fsm.change_state.bind(crabby_chase_state))
	
	crabby_chase_state.player_exited.connect(fsm.change_state.bind(crabby_wander_state))
	crabby_chase_state.player_in_attack_range.connect(fsm.change_state.bind(crabby_attack_state))
	
	crabby_attack_state.player_exited_attack_range.connect(fsm.change_state.bind(crabby_chase_state))


func _physics_process(delta):
	ray_cast.target_position.x = direction * 30
	animator.flip_h = false if direction == -1 else true
	
	health_bar.value = health
	
	if not is_on_floor():
		velocity.y += gravity * delta


func take_damage(damage: int):
	if health > 0:
		health -= damage
	if health == 0:
		fsm.change_state(crabby_death_state)


func crabby():
	pass
