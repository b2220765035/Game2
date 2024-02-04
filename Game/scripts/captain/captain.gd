class_name Captain
extends CharacterBody2D


@export var speed = 100
@export var animator: AnimatedSprite2D


@onready var attack_range = $attack_range

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var captain_idle_state = $FiniteStateMachine/CaptainIdleState as CaptainIdleState
@onready var captain_run_state = $FiniteStateMachine/CaptainRunState as CaptainRunState
@onready var captain_jump_state = $FiniteStateMachine/CaptainJumpState as CaptainJumpState
@onready var captain_attack_state = $FiniteStateMachine/CaptainAttackState as CaptainAttackState

@onready var healt_bar = $health_bar


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

var maxHealth = 100
var health = maxHealth


func _ready():
	captain_idle_state.movement_begin.connect(fsm.change_state.bind(captain_run_state))
	captain_idle_state.jump.connect(fsm.change_state.bind(captain_jump_state))
	captain_idle_state.attack.connect(fsm.change_state.bind(captain_attack_state))
	
	captain_run_state.movement_stop.connect(fsm.change_state.bind(captain_idle_state))
	captain_run_state.jump.connect(fsm.change_state.bind(captain_jump_state))
	captain_run_state.attack.connect(fsm.change_state.bind(captain_attack_state))
	
	captain_jump_state.state_finished.connect(fsm.change_state.bind(captain_idle_state))
	
	captain_attack_state.state_finished.connect(fsm.change_state.bind(captain_idle_state))
	
	
func _physics_process(delta):
	attack_range.position.x = direction * 17 
	
	animator.flip_h = true if direction == -1 else false
	
	healt_bar.value = health
	
	if not is_on_floor():
		velocity.y += gravity * delta


func captain():
	pass

#@onready var animation_timer = $animation_timer
#@onready var cooldown_timer = $cooldown_timer
#@onready var _animated_sprite = $AnimatedSprite2D
#
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var crabby = null
#var is_sprinting=false
#var sprint_value=1
#var cooldown = true
#var animation_in_process = false
#var in_attack_range = false
#
#
#func _physics_process(delta):
#
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	#if Input.is_action_pressed("sprint") and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		#is_sprinting=true
		#sprint_value=1.2
		#_animated_sprite.speed_scale = 1.2
	#else:
		#is_sprinting=false
		#sprint_value=1
		#_animated_sprite.speed_scale = 1
#
#
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = -350
#
#
	#var direction = Input.get_axis("move_left","move_right")
#
	#velocity.x = 200 * direction * sprint_value
	#move_and_slide()
#
#func _process(delta):
	#if Input.is_action_just_pressed("attack1") and cooldown:
		#animation_in_process = true
		#animation_timer.start()
		#cooldown = false
		#cooldown_timer.start()
		#if in_attack_range:
			#crabby.is_alive = false
	#
	#if animation_in_process:
		#_animated_sprite.play("attack 1")
	#elif velocity.y < 0:
		#if velocity.x > 0:
			#get_node("attack_range").position=Vector2(0, 0)
			#_animated_sprite.flip_h=false
		#elif velocity.x < 0:
			#get_node("attack_range").position=Vector2(-34.245, 0)
			#_animated_sprite.flip_h=true
		#_animated_sprite.play("jump sword")
	#elif velocity.y > 0:
		#if velocity.x > 0:
			#get_node("attack_range").position=Vector2(0, 0)
			#_animated_sprite.flip_h=false
		#elif velocity.x < 0:
			#get_node("attack_range").position=Vector2(-34.245, 0)
			#_animated_sprite.flip_h=true
		#_animated_sprite.play("fall sword")
	#elif velocity.x > 0:
		#get_node("attack_range").position=Vector2(0, 0)
		#_animated_sprite.flip_h=false
		#_animated_sprite.play("run sword")
	#elif velocity.x < 0:
		#get_node("attack_range").position=Vector2(-34.245, 0)
		#_animated_sprite.flip_h=true
		#_animated_sprite.play("run sword")
	#else:			
		#_animated_sprite.play("idle")
#
#
#func _on_timer_timeout():
	#print("zaman")
#
#
#func _on_attack_range_body_entered(body):
	#if body.has_method("crabby"):
		#in_attack_range = true
		#crabby = body
#
#
#func _on_attack_range_body_exited(body):
	#if body.has_method("crabby"):
		#in_attack_range = false
		#crabby = null
#
#
#func _on_animation_timer_timeout():
	#animation_in_process = false
#
#
#func _on_cooldown_timer_timeout():
	#cooldown = true
