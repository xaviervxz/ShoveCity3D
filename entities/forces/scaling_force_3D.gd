class_name ScalingForce3D extends BasicForce3D

@export var force_scaling : float = 1
@export var edge_strength : float = 1000
@export var range : int
@export var aoe_range : int

func _ready():
	super._ready()
	aoe_range = $AreaOfEffect.shape.radius
	if !range:
		range = aoe_range


func get_strength_at_point(point) -> float:
	var distance = (position - point).length() 
	var percent_far = distance / range
	return percent_far*edge_strength + (1-percent_far)*strength


func get_orientation_of_force_at_point(point) -> Vector3:
	return (position - point).normalized()
	
