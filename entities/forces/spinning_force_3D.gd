class_name SpinningForcesvw3D extends ScalingForce3D

@export var clockwise:bool = true

func get_orientation_of_force_at_point(point) -> Vector3:
	var orientation = super.get_orientation_of_force_at_point(point)
	return Vector3(orientation.z, 0, -orientation.x)
