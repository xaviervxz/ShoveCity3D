class_name FlatEntity extends RigidBody3D



# how often to check if flipped, fallen, or other states
@export var state_change_check_rate : float = .2
# the counter for the amount of time passed between state checks
var curr_check_progress: float = 0

# Statuses: Flipped
@export var flippable : bool = true
signal flipped(is_upsidedown, at_position)
var is_upside_down : bool = false

func _physics_process(delta):
	curr_check_progress += delta
	if curr_check_progress > state_change_check_rate:
		if flippable:
			has_flipped()
		curr_check_progress = 0
	


func flat_pos() -> Vector2:
	return Vector2(position.x, position.z)

func flat_rot() -> float:
	return rotation.y

func has_flipped() -> bool:
	var up : Vector3 = $Faceup.global_position
	var down : Vector3 = $Facedown.global_position
	var minimum_flippedness = up.distance_to(down)*.5
	var flippedness = up.y-down.y
	if not is_upside_down:  #If rightside-up, see if up has dropped below down by a significant margin
		if flippedness < minimum_flippedness*-1:
			print("flipped down: (%0.3f,%0.3f,%0.3f) - (%0.3f,%0.3f,%0.3f) = %.3f ? %.3f"%
				[ up.x, up.y, up.z, down.x, down.y, down.z,flippedness, minimum_flippedness])
			is_upside_down = true
			flipped.emit(is_upside_down, position)
			cry_alarm()
			return true
		else:
			return false
	else: #If upside-down, see if up risen above down by a significant margin
		if flippedness > minimum_flippedness:
			print("flipped up: (%0.3f,%0.3f,%0.3f) - (%0.3f,%0.3f,%0.3f) = %.3f ? %.3f"%
				[ up.x, up.y, up.z, down.x, down.y, down.z,flippedness, minimum_flippedness])
			is_upside_down = false
			flipped.emit(is_upside_down, position)
			cry_alarm()
			return true
		else:
			return false
		
func cry_alarm():
	var noisemaker : AudioStreamPlayer3D =$Alarm 
	noisemaker.play()
	
		
		
		
