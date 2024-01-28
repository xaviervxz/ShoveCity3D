class_name EngineFlare extends Node3D


func flare():
	visible=true
	$FlameTimer.start()


func _on_flame_timer_timeout():
	visible=false
