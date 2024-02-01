class_name Plunger extends FlatEntity

@export_enum("extending","retracting","neutral") var state = "neutral"
@export var strength : float = 100
@onready var start_pos = position
signal retracted

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if state != "neutral":
		var parent : RigidBody3D = get_parent()
		var orientation = $FrontMarker.global_position - global_position
		var force = orientation *strength
		if state == "retracting":
			if position.distance_to(start_pos) <.01 :
				state = "neutral"
				emit_signal("retracted")
			else:
				force = force *-1
				apply_central_force(force)
				get_parent().apply_force(-force, position)
		elif state == "expanding":
			force = force * 2
			apply_central_force(force)
			get_parent().apply_force(-force, position)

func expand():
	state = "expanding"
	$Timer.start()

func retract():
	if state =="expanding":
		state = "retracting"
		$Timer.start()

func generate_force(outward : bool = true):
	var parent : RigidBody3D = get_parent()
	var orientation = $FrontMarker.global_position - global_position
	var force = orientation * strength
	if outward:
		force = force * 2
	else: 
		force = force * -1
	print(position)
	print(position.distance_to(start_pos))
	if state == "retracting":
		if position.distance_to(start_pos) <.01 :
			state = "neutral"
		else:
			force = force
			apply_central_impulse(force)
			get_parent().apply_impulse(-force, position)
	elif state == "expanding":
		force = force * 2
		apply_central_impulse(force)
		get_parent().apply_impulse(-force, position)
	

func _on_timer_timeout():
	print("Plunger Timeout @ state %s" %[state])
	if state == "expanding":
		state = "retracting"
		print("Plunger TimerStart @ state %s" %[state])
		$Timer.start()
	if state == "retracting":
		state = "neutral"
		emit_signal("retracted")


