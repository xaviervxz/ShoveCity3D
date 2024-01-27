class_name SpinningForce3D extends ScalingForce3D

@export var clockwise:bool = true

func get_orientation_of_force_at_point(point) -> Vector3:
	var orientation = super.get_orientation_of_force_at_point(point)
	var result = Vector3(orientation.z, 0,-orientation.x)
	if not clockwise:
		result = result * -1
	return result
