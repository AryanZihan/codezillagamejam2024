extends Area2D


func _physics_process(delta: float) -> void:
	var player_in_range = get_overlapping_bodies()
	if player_in_range.size() > 0:
		var target_player = player_in_range[0]
		look_at(target_player.global_position)


func shoot():
	const BUllET = preload("res://bullet.tscn")
	var new_bullet = BUllET.instantiate()
	
	

func _on_timer_timeout() -> void:
	shoot()
	 
