class_name CylindricalAreaOfEffect extends CollisionShape3D

@export var color : Color 

func _ready():
	var mesh : CylinderMesh = $Mesh.mesh
	var core_shape : CylinderShape3D = shape
	mesh.top_radius = core_shape.radius
	mesh.bottom_radius = core_shape.radius
	mesh.height = core_shape.height
