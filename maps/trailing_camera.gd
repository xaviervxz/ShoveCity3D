class_name TrailingCamera extends Camera3D

@export var target : Node3D
@export var default_camera_height : float = 6
@export var max_camera_height : float = 10

@export var FOLLOW_SPEED : float = .5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var source_pos = target.global_position
	var cam_pos = global_position
	var distance = get_distance_on_plane(source_pos, cam_pos, "xz")
	var desired_height = max_camera_height - (max_camera_height-default_camera_height)/distance
	var cam_height = source_pos.y + max(default_camera_height, min(max_camera_height, desired_height))
	var source_pos_on_cam_plane = Vector3(source_pos.x, cam_height, source_pos.z)
	
	global_position = global_position.lerp(source_pos_on_cam_plane, delta * distance * FOLLOW_SPEED)

# Assume xz plane; that's the standard top-down perspective in Godot
func get_distance_on_plane(obj1:Vector3, obj2:Vector3, plane:String = "xz"):
	var pos1 = Vector2(obj1.x, obj1.z)
	var pos2 = Vector2(obj2.x, obj2.z)
	if "y" in plane:
		if "x" in plane:
			pos1.y = obj1.y
			pos2.y = obj2.y
		else : 
			pos1.x = obj1.y
			pos2.x = obj2.y
	return pos1.distance_to(pos2)
