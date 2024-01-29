

class_name Projectile3D extends RigidBody3D

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

func try_bounce(delta):
	var col = collision_test(delta)
	if col:
		bounce(col.get_position())
		var target = col.get_collider()
		if target is Player:
			target.hit(self, col)

func bounce(collision_point):
	if bounces < 1:
		die()
	else:
		bounces = bounces-1
	

func collision_test(delta):
	return move_and_collide(linear_velocity*delta, true)
	
func die():
	emit_signal("dead")
	queue_free()
	
func launch(force):
	residual_acceleration = force
	apply_central_force(residual_acceleration)
	$Timer.start()

func _on_timer_timeout():
	residual_acceleration = Vector3(0,0,0)
