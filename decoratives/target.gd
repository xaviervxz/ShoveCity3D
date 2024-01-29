extends Node3D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var location = ScreenPointToRay()
	if location:
		location.y = location.y+.1
		position = location

func ScreenPointToRay():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var rayOG = camera.project_ray_origin(mousePos)
	var rayEND = rayOG + camera.project_ray_normal(mousePos) * 2000
	
	var query = PhysicsRayQueryParameters3D.create(rayOG, rayEND)
	var rayArray = spaceState.intersect_ray(query)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
	
