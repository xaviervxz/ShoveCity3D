class_name Turret extends RigidBody3D

@export var target : Node3D 
@export var attack_speed :float = 1
@export var launch_strength : int = 1000

@onready var cannonball =  preload("res://entities/raw_objs/projectiles/cannon_ball.tscn")

func _physics_process(delta):
	aimAt(target)
	

func aimAt(target):
	var target_pos = target.global_position - global_position
	var angle = atan(target_pos.x/target_pos.z)
	if target_pos.z < 0:
		angle = angle + 179
	global_rotation = Vector3(0,angle,0)
	
func fire(projectile = cannonball, timer : Timer = $Timer):
	
	if timer.is_stopped():
		timer.wait_time = attack_speed
		timer.start()
		var stage = get_parent()
		while not stage is Stage3D:
			stage = stage.get_parent()
		
		var proj : RigidBody3D = projectile.instantiate()
		proj.global_position = $BarrelTip.global_position
		var root_pos = global_position
		var root_loc = position
		var proj_loc = proj.global_position
		var trajectory = proj.position - global_position
		print("Launching at trajectory: %s %s %s" % [trajectory.x, trajectory.y, trajectory.z])
		
		
		stage.spawn_projectile(proj)
		proj.launch(trajectory * launch_strength)


