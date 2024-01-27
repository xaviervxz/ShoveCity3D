class_name Player extends RigidBody3D


var attack_speed : float = .1
var primary_enabled = true
var secondary_enabled = true

signal collision(collision)

@export var thrust = 100
@export var torque = 100

#@onready var cannonball =  preload("res://entities/projectiles/cannonball/simple_cannonball.tscn")
#@onready var simpleball =  preload("res://entities/projectiles/flaming_cannonball/flaming_cannonball.tscn")

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var y_direction = Input.get_axis("player_forward", "player_backward")
	var x_direction = Input.get_axis("player_strafe_left", "player_strafe_right")
	var spin_direction = Input.get_axis("player_spin_left","player_spin_right")
	var thruster : Thruster = $Thruster
	thruster.thrust(y_direction)
	var force = Vector3(0,0,0) * thrust * mass
	apply_force(force)
	if spin_direction:
		apply_torque(Vector3(0,spin_direction * torque,0))
		
		
func _unhandled_input(event):
	if event.is_action_pressed("player_action_primary"):
		fire_cannon()
	elif event.is_action_pressed("player_action_secondary"):
		fire_shooter()
		
		
func fire_cannon():
	print("fire(cannonball, $PrimaryTimer)")
func fire_shooter():
	print("fire(simpleball, $SecondaryTimer)")
		
func fire(projectile, timer):
	if timer.is_stopped():
		timer.wait_time = 1 * attack_speed
		timer.start()
		var stage = get_parent()
		if stage is Stage3D:
			
			var proj = projectile.instantiate()
			var angle = -rotation.y +PI 
			var firing_distance = $BarrelTip.position.length()
			var trajectory = Vector2(sin(angle), cos(angle))
			proj.position = position + trajectory * firing_distance
			proj.rotation = rotation
			proj.apply_central_impulse(trajectory*1000)
			
			stage.spawn_projectile(proj)
			pass
			
		
		
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







