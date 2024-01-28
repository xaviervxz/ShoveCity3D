class_name FullJoint extends RigidBody3D

@export var target1: RigidBody3D
@export var target2: RigidBody3D

func _ready():
	assign_targets()
	print("done")

func assign_targets():
	if target1:
		for pin : PinJoint3D in $JointSet1.get_children():
			pin.node_b = target1.get_path()
	if target2:
		for pin : PinJoint3D in $JointSet2.get_children():
			pin.node_b = target2.get_path()
	
