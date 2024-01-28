class_name Thruster extends RigidBody3D

@export var force: float = 50

func fire(scale):
	var power = scale * force
	if power > 0:
		thrust(power)
		$BackFlare.flare()
	else:
		thrust(power/10)
		$FrontFlare.flare()

func thrust(power):
	var target_marker : Node3D = $Targeting
	var target_direction = target_marker.global_position - global_position
	apply_central_force(target_direction*power)


func _on_flame_timer_timeout():
	$Flame.visible = false
