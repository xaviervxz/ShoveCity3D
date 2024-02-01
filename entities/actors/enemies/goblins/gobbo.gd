class_name Goblin extends FlatEntity

@onready var rng = RandomNumberGenerator.new()

func _on_noise_timer_timeout():
	if is_upside_down:
		make_noise("Idle")
	else:
		make_noise("Idle2")
	$NoiseTimer.start(rng.randf_range(2.0, 5.0))

func make_noise(player_path:String):
	var noisemaker : AudioStreamPlayer3D = get_node(player_path) 
	noisemaker.play()
