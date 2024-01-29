class_name Stage3D extends Node3D


var projectiles_group = "projectiles"
var pointers_group = "pointers"
signal group_changed

func spawn_object(obj, group):
	add_child(obj)
	move_child(obj, 0)
	obj.add_to_group(group)
	var nodes_in_group = get_tree().get_nodes_in_group(group)

	emit_signal("group_changed", group, nodes_in_group.size())
	

func spawn_projectile(obj):
	spawn_object(obj, projectiles_group)
	obj.dead.connect(_on_projectile_dead)
	
	
func _on_projectile_dead():
	var nodes_in_group = get_tree().get_nodes_in_group(projectiles_group)
	emit_signal("group_changed", projectiles_group, nodes_in_group.size()-1)
