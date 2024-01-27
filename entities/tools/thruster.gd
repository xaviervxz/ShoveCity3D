class_name Thruster extends RigidBody3D

@export var force: float = 50

func fire(scale):
	var power = scale * force
	if power > 0:
		thrust(power)
	else:
		thrust(power/10)

func thrust(power):
	var target_direction : Node3D = $Targeting
	apply_central_force(target_direction.position*power)
