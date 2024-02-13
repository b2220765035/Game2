class_name Captain
extends CharacterBody2D


@export var speed = 100
@export var animator: AnimatedSprite2D


@onready var attack_range = $attack_range
@onready var air_attack_range = $air_attack_range

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var captain_idle_state = $FiniteStateMachine/CaptainIdleState as CaptainIdleState
@onready var captain_run_state = $FiniteStateMachine/CaptainRunState as CaptainRunState
@onready var captain_jump_state = $FiniteStateMachine/CaptainJumpState as CaptainJumpState
@onready var captain_attack_state = $FiniteStateMachine/CaptainAttackState as CaptainAttackState
@onready var captain_fall_state = $FiniteStateMachine/CaptainFallState as CaptainFallState
@onready var captain_air_attack_state = $FiniteStateMachine/CaptainAirAttackState as CaptainAirAttackState
@onready var captain_hit_state = $FiniteStateMachine/CaptainHitState as CaptainHitState
@onready var captain_throw_sword_state = $FiniteStateMachine/CaptainThrowSwordState as CaptainThrowSwordState

@onready var healt_bar = $health_bar

@onready var text_box = $TextEdit


var sword_scene = preload("res://scenes/sword.tscn")
var sword_instance = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var is_falling = true
var can_jump = true
var has_sword = true

var maxHealth = 100
var health = maxHealth


func _ready():
	captain_idle_state.movement_begin.connect(fsm.change_state.bind(captain_run_state))
	captain_idle_state.jump.connect(fsm.change_state.bind(captain_jump_state))
	captain_idle_state.attack.connect(fsm.change_state.bind(captain_attack_state))
	captain_idle_state.throw_sword.connect(fsm.change_state.bind(captain_throw_sword_state))
	
	captain_run_state.movement_stop.connect(fsm.change_state.bind(captain_idle_state))
	captain_run_state.jump.connect(fsm.change_state.bind(captain_jump_state))
	captain_run_state.attack.connect(fsm.change_state.bind(captain_attack_state))
	captain_run_state.fall.connect(fsm.change_state.bind(captain_fall_state))
	captain_run_state.throw_sword.connect(fsm.change_state.bind(captain_throw_sword_state))
	
	captain_jump_state.fall.connect(fsm.change_state.bind(captain_fall_state))
	captain_jump_state.air_attack.connect(fsm.change_state.bind(captain_air_attack_state))
	
	captain_fall_state.idle.connect(fsm.change_state.bind(captain_idle_state))
	captain_fall_state.run.connect(fsm.change_state.bind(captain_run_state))
	captain_fall_state.air_attack.connect(fsm.change_state.bind(captain_air_attack_state))
	
	captain_attack_state.state_finished.connect(fsm.change_state.bind(captain_idle_state))
	
	captain_air_attack_state.state_finished.connect(fsm.change_state.bind(captain_fall_state))
	captain_air_attack_state.run.connect(fsm.change_state.bind(captain_run_state))
	captain_air_attack_state.idle.connect(fsm.change_state.bind(captain_idle_state))
	
	captain_hit_state.idle.connect(fsm.change_state.bind(captain_idle_state))
	captain_hit_state.run.connect(fsm.change_state.bind(captain_run_state))
	captain_hit_state.fall.connect(fsm.change_state.bind(captain_fall_state))
	
	captain_throw_sword_state.state_finished.connect(fsm.change_state.bind(captain_idle_state))
	
	
func _physics_process(delta):
	attack_range.position.x = direction * 17
	air_attack_range.scale.x = direction
	
	animator.flip_h = true if direction == -1 else false
	
	healt_bar.value = health
	
	text_box.text = fsm.state._get_state_name()

	if not is_on_floor() and is_falling:
		velocity.y += gravity * delta


func take_damage(amount: int):
	health -= 20
	fsm.change_state(captain_hit_state)


func captain():
	pass
