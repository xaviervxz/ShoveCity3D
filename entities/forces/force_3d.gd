class_name BasicForce3D extends Area3D

@export var strength : float
@export var direction : Vector3

func _ready():
	if !strength:
		strength = 1000
	if !direction:
		direction = Vector3(0,0,1)

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is RigidBody3D:
			var force_val = get_strength_at_point(body.position)
			var force_orientation = get_orientation_of_force_at_point(body.position)
			body.apply_central_force(force_val * force_orientation * delta)

func get_strength_at_point(point) -> float:
	return strength


func get_orientation_of_force_at_point(point) -> Vector3:
	return direction.normalized()
	
	
func get_reciprocal_force_from_object(obj):
	return Vector3(0,0,0)
