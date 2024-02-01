class_name Player extends FlatEntity


var attack_speed : float = .1
var primary_enabled = true
var secondary_enabled = true

signal collision(collision)

@export var thrust = 100
@export var torque = 10
@export var target : Node3D

#@onready var simpleball =  preload("res://entities/projectiles/flaming_cannonball/flaming_cannonball.tscn")
func _ready():
	$Turret.target = target

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var y_direction = Input.get_axis("player_backward","player_forward")
	var x_direction = Input.get_axis("player_strafe_left", "player_strafe_right")
	var spin_direction = Input.get_axis("player_spin_right","player_spin_left")
	if y_direction:
		for thruster : Thruster in $Engines.get_children():
			thruster.fire(y_direction)
	if spin_direction:
		var dir = angular_velocity.y
		var strength = spin_direction * torque
		if (dir > 0 and strength < 0) or (dir < 0 and strength > 0):
			strength = strength * 2
		apply_torque(Vector3(0,strength,0))
		
		
func _unhandled_input(event):
	if event.is_action_pressed("player_action_primary"):
		fire_cannon()
	elif event.is_action_pressed("player_action_secondary"):
		fire_shooter()
	elif event.is_action_released("player_action_secondary"):
		unfire_shooter()
	elif event.is_action_pressed("world_reset"):
		get_parent().reset_world()
		
		
func fire_cannon():
	$Turret.fire()
func fire_shooter():
	$Plunger/Pin.enabled = false
	$Plunger.expand()
func unfire_shooter():
	$Plunger.retract()

		
func _on_plunger_retracted():
	$Plunger/Pin.enabled=true
			
		
		
func exit_point(angle, size):
	angle = angle + 3*PI/4
	return position - size*Vector2(cos(angle), sin(angle))
	


func _on_secondary_timer_timeout():
	secondary_enabled = true
	$SecondaryTimer.stop()


func _on_primary_timer_timeout():
	primary_enabled = true
	$PrimaryTimer.stop()


func change_atkspd(ratio):
	attack_speed = attack_speed * ratio


func on_hit(col: KinematicCollision3D):
	emit_signal("collision", col)




func hit(a, b):
	print("hit")




