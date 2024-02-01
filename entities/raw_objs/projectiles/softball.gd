

class_name SoftProjectile3D extends SoftBody3D

const explosive_force = 1
var bounces = 10

signal dead

var residual_acceleration = Vector3(0,0,0)

func _physics_process(delta):
	pass

func hit(_in_weight : float, _in_velocity : Vector3, _global_collision_point : Vector3):
	if bounces < 1:
		die()
	else:
		bounces = bounces-1


func bounce(collision_point):
	if bounces < 1:
		die()
	else:
		bounces = bounces-1
	

	
func die():
	emit_signal("dead")
	queue_free()
	
func launch(force):
	residual_acceleration = force

func _on_timer_timeout():
	residual_acceleration = Vector3(0,0,0)
